import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx2/repositories/parse_errors.dart';
import 'package:xlo_mobx2/repositories/table_keys.dart';

class AdRepository {
  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);
      final parseUser = ParseUser('', '', '')..set(KeyUserId, ad.user.id);
      final adObject = ParseObject(KeyAdTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject.set<String>(KeyAdTitle, ad.title);
      adObject.set<String>(KeyAdDescription, ad.description);
      adObject.set<bool>(KeyAdHidePhone, ad.hidePhone);
      adObject.set<num>(KeyAdPrice, ad.price);
      adObject.set<int>(KeyAdTitle, ad.status.index);

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
      return Future.error('Falha ao salvar anúncio');
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
}
