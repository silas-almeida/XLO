import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:xlo_mobx2/repositories/ad_repository.dart';
import 'package:xlo_mobx2/stores/user_manager_store.dart';
part 'myads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    _getMyAds();
  }

  @observable
  List<Ad> allAds = [];

  @computed
  List<Ad> get activeAds =>
      allAds.where((ad) => ad.status == AdStatus.ACTIVE).toList();

  @computed
  List<Ad> get pendingAds =>
      allAds.where((ad) => ad.status == AdStatus.PENDING).toList();

  @computed
  List<Ad> get soldAds =>
      allAds.where((ad) => ad.status == AdStatus.SOLD).toList();

  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user;

    try {
      loading = true;
      allAds = await AdRepository().getMyAds(user);
      loading = false;
    } catch (e) {}
  }

  @observable
  bool loading = false;

  void refresh() => _getMyAds();

  @action
  Future<void> soldAd(Ad ad) async {
    loading = true;
    await AdRepository().sold(ad);
    refresh();
  }

  @action
  Future<void> deleteAd(Ad ad) async {
    loading = true;
    await AdRepository().delete(ad);
    refresh();
  }
}
