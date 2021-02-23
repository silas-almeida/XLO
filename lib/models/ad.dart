import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx2/models/address.dart';
import 'package:xlo_mobx2/models/category.dart';
import 'package:xlo_mobx2/models/city.dart';
import 'package:xlo_mobx2/models/uf.dart';
import 'package:xlo_mobx2/models/user.dart';
import 'package:xlo_mobx2/repositories/table_keys.dart';
import 'package:xlo_mobx2/repositories/user_repository.dart';

enum AdStatus {
  PENDING,
  ACTIVE,
  SOLD,
  DELETED,
}

class Ad {
  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(KeyAdTitle);
    description = object.get<String>(KeyAdDescription);
    images = object
        .get<List>(KeyAdImages)
        .map((parseFile) => parseFile.url)
        .toList();
    price = object.get<num>(KeyAdPrice);
    createdAt = object.createdAt;
    address = Address(
      district: object.get<String>(KeyAdDistrict),
      city: City(name: object.get<String>(KeyAdCity)),
      cep: object.get<String>(KeyAdPostalCode),
      uf: UF(initials: object.get<String>(KeyAdFederativeUnit)),
    );
    views = object.get<int>(KeyAdViews, defaultValue: 0);
    status = AdStatus.values[object.get<int>(KeyAdStatus)];
    user = UserRepository().mapParseToUser(object.get<ParseUser>(KeyAdOwner));
    category = Category.fromParse(object.get<ParseObject>(KeyAdCategory));
  }

  Ad();

  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  AdStatus status = AdStatus.PENDING;
  DateTime createdAt;
  User user;
  int views;
}
