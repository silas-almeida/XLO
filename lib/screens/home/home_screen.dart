import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx2/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx2/screens/home/components/search_dialog.dart';
import 'package:xlo_mobx2/stores/home_store.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSearch(BuildContext context) async {
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(
              currentSearch: homeStore.search,
            ));
    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(builder: (_) {
            if (homeStore.search.isEmpty)
              return Container();
            else {
              return GestureDetector(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return Container(
                      width: constraints.biggest.width,
                      child: Text(homeStore.search),
                    );
                  },
                ),
                onTap: () => openSearch(context),
              );
            }
          }),
          actions: [
            Observer(builder: (_) {
              if (homeStore.search.isEmpty) {
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    openSearch(context);
                  },
                );
              }
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  homeStore.setSearch('');
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
