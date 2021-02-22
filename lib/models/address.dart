import 'package:xlo_mobx2/models/city.dart';
import 'package:xlo_mobx2/models/uf.dart';

class Address {
  Address({this.uf, this.cep, this.city, this.district});

  UF uf;
  City city;
  String cep;
  String district;

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, district: $district}';
  }
}
