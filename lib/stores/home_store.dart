import 'package:mobx/mobx.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:xlo_mobx2/models/category.dart';
import 'package:xlo_mobx2/repositories/ad_repository.dart';
import 'package:xlo_mobx2/stores/filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    autorun((_) async {
      try {
        setLoading(true);
        final newAds = await AdRepository().getHomeAdList(
          filter: filter,
          search: search,
          category: category,
          page: page,
        );
        addNewAds(newAds);
        setError(null);
      } catch (e) {
        setError(e);
      }
      setLoading(false);
    });
  }

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();

  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    filter = value;
    resetPage();
  }

  @observable
  int page = 0;

  @action
  void loadNextPage() {
    page++;
  }

  @observable
  bool lastPage = false;

  @action
  void addNewAds(List<Ad> newAds) {
    print('add ${newAds.length}');
    if (newAds.length < 6) {
      lastPage = true;
    }
    adList.addAll(newAds);
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;
}
