import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx2/models/city.dart';
import 'package:xlo_mobx2/models/uf.dart';

class IBGERepository {
  Future<List<UF>> getUfList() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('UF_LIST')) {
      print('Teve preferência salva');
      final jsonList = json.decode(preferences.get('UF_LIST'));
      final ufList = jsonList.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort(
          (UF a, UF b) => a.name.toLowerCase().compareTo(
                b.name.toLowerCase(),
              ),
        );
      return ufList;
    }
    const endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endPoint);
      final ufList = response.data.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort(
          (UF a, UF b) => a.name.toLowerCase().compareTo(
                b.name.toLowerCase(),
              ),
        );

      preferences.setString('UF_LIST', json.encode(response.data));

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter lista de Estados');
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';
    try {
      final response = await Dio().get<List>(endPoint);
      final cityList = response.data
          .map<City>((json) => City.fromJson(json))
          .toList()
            ..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return cityList;
    } on DioError {
      return Future.error('Falha ao carregar cidades');
    }
  }
}
