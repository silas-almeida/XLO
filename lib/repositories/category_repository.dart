import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx2/models/category.dart';
import 'package:xlo_mobx2/repositories/parse_errors.dart';
import 'package:xlo_mobx2/repositories/table_keys.dart';

class CategoryRepsitory {
  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(KeyCategoyTable))
      ..orderByAscending(KeyCategoryDescription);
    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((po) => Category.fromParse(po)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
