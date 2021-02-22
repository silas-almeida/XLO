import 'package:dio/dio.dart';
import 'package:xlo_mobx2/models/address.dart';
import 'package:xlo_mobx2/models/city.dart';
import 'package:xlo_mobx2/repositories/ibge_repository.dart';

class CepRepository {
  Future<Address> getAddresFromApi(String cep) async {
    if (cep == null || cep.isEmpty) {
      return Future.error('CEP inválido');
    }
    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');
    if (clearCep.length != 8) {
      return Future.error('CEP inválido!');
    }
    final endPoint = 'https://viacep.com.br/ws/$clearCep/json';

    try {
      final response = await Dio().get<Map>(endPoint);
      if (response.data.containsKey('erro') && response.data['erro']) {
        return Future.error('CEP inválido');
      }
      final ufList = await IBGERepository().getUfList();

      return Address(
        cep: response.data['cep'],
        district: response.data['bairro'],
        city: City(
          name: response.data['localidade'],
        ),
        uf: ufList.firstWhere((uf) => uf.initials == response.data['uf']),
      );
    } catch (e) {
      return Future.error('Falha ao buscar CEP');
    }
  }
}
