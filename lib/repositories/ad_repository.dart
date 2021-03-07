import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx2/models/category.dart' as cat;
import 'package:xlo_mobx2/models/user.dart';
import 'package:xlo_mobx2/repositories/parse_errors.dart';
import 'package:xlo_mobx2/repositories/table_keys.dart';
import 'package:xlo_mobx2/stores/filter_store.dart';

class AdRepository {
  Future<List<Ad>> getHomeAdList({
    @required FilterStore filter,
    @required String search,
    @required cat.Category category,
    @required int page,
  }) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(KeyAdTable));
    queryBuilder.includeObject([KeyAdOwner, KeyAdCategory]);

    queryBuilder.setAmountToSkip(page * 6);
    queryBuilder.setLimit(6);

    queryBuilder.whereEqualTo(KeyAdStatus, AdStatus.ACTIVE.index);

    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(KeyAdTitle, search, caseSensitive: false);
    }

    if (category != null && category.id != '*') {
      queryBuilder.whereEqualTo(
        KeyAdCategory,
        (ParseObject(KeyCategoyTable)
              ..set(
                KeyCategoryId,
                category.id,
              ))
            .toPointer(),
      );
    }

    switch (filter.orderBy) {
      case OrderBy.PRICE:
        queryBuilder.orderByAscending(KeyAdPrice);
        break;
      case OrderBy.DATE:
      default:
        queryBuilder.orderByDescending(KeyAdCreatedAt);
        break;
    }

    if (filter.minPrice != null && filter.minPrice > 0) {
      queryBuilder.whereGreaterThanOrEqualsTo(KeyAdPrice, filter.minPrice);
    }

    if (filter.maxPrice != null && filter.maxPrice > 0) {
      queryBuilder.whereLessThanOrEqualTo(KeyAdPrice, filter.maxPrice);
    }

    if (filter.vendorType != null &&
        filter.vendorType > 0 &&
        filter.vendorType <
            (VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR)) {
      //Query de users
      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

      if (filter.vendorType == VENDOR_TYPE_PARTICULAR) {
        userQuery.whereEqualTo(KeyUserType, UserType.PARTICULAR.index);
      } else {
        userQuery.whereEqualTo(KeyUserType, UserType.PROFESSIONAL.index);
      }

      queryBuilder.whereMatchesQuery(KeyAdOwner, userQuery);
    }

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results.map((po) => Ad.fromParse(po)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);
      final parseUser = ParseUser('', '', '')..set(KeyUserId, ad.user.id);
      final adObject = ParseObject(KeyAdTable);

      if (ad.id != null) {
        adObject.objectId = ad.id;
      }

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject.set<String>(KeyAdTitle, ad.title);
      adObject.set<String>(KeyAdDescription, ad.description);
      adObject.set<bool>(KeyAdHidePhone, ad.hidePhone);
      adObject.set<num>(KeyAdPrice, ad.price);
      adObject.set<int>(KeyAdStatus, ad.status.index);

      adObject.set<String>(KeyAdDistrict, ad.address.district);
      adObject.set<String>(KeyAdCity, ad.address.city.name);
      adObject.set<String>(KeyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(KeyAdPostalCode, ad.address.cep);

      adObject.set<List<ParseFile>>(KeyAdImages, parseImages);

      adObject.set<ParseUser>(KeyAdOwner, parseUser);

      adObject.set<ParseObject>(KeyAdCategory,
          ParseObject(KeyCategoyTable)..set(KeyCategoryId, ad.category.id));
      final response = await adObject.save();
      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha ao salvar anúncio: $e ');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];
    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error.code));
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error('Falha ao salvar imagens');
    }
  }

  Future<List<Ad>> getMyAds(User user) async {
    final currentUser = ParseUser('', '', '')..set(KeyUserId, user.id);
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(KeyAdTable));
    queryBuilder.setLimit(20);
    queryBuilder.orderByDescending(KeyAdCreatedAt);
    queryBuilder.whereEqualTo(KeyAdOwner, currentUser.toPointer());
    queryBuilder.includeObject([KeyAdCategory, KeyAdOwner]);

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results.map((po) => Ad.fromParse(po)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> sold(Ad ad) async {
    final parseObject = ParseObject(KeyAdTable)..set(KeyAdId, ad.id);

    parseObject.set(KeyAdStatus, AdStatus.SOLD.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> delete(Ad ad) async {
    final parseObject = ParseObject(KeyAdTable)..set(KeyAdId, ad.id);

    parseObject.set(KeyAdStatus, AdStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
