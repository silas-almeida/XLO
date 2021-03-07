import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx2/screens/myads/components/active_tile.dart';
import 'package:xlo_mobx2/screens/myads/components/empty_card.dart';
import 'package:xlo_mobx2/screens/myads/components/pending_tile.dart';
import 'package:xlo_mobx2/screens/myads/components/sold_tile.dart';
import 'package:xlo_mobx2/stores/myads_store.dart';

class MyAdsScreen extends StatefulWidget {
  MyAdsScreen({this.initialPage = 0});
  final int initialPage;

  @override
  _MyAdsScreeState createState() => _MyAdsScreeState();
}

class _MyAdsScreeState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  final MyAdsStore store = MyAdsStore();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus Anúncios'),
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(
                child: Text('Ativos'),
              ),
              Tab(
                child: Text('Pendentes'),
              ),
              Tab(
                child: Text('Vendidos'),
              ),
            ],
          ),
        ),
        body: Observer(
          builder: (_) {
            if (store.loading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            } else
              return TabBarView(
                controller: tabController,
                children: [
                  Observer(
                    builder: (_) {
                      if (store.activeAds.isEmpty)
                        return EmptyCard(
                          text: 'Nenhum anúncio ativo!',
                        );
                      return ListView.builder(
                        itemCount: store.activeAds.length,
                        itemBuilder: (_, index) {
                          return ActiveTile(store.activeAds[index], store);
                        },
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      if (store.pendingAds.isEmpty)
                        return EmptyCard(text: 'Nenhum anúncio pendente!');
                      return ListView.builder(
                        itemCount: store.pendingAds.length,
                        itemBuilder: (_, index) {
                          return PendingTile(store.pendingAds[index]);
                        },
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      if (store.soldAds.isEmpty)
                        return EmptyCard(text: 'Nenhum anúncio vendido!');
                      return ListView.builder(
                        itemCount: store.soldAds.length,
                        itemBuilder: (_, index) {
                          return SoldTile(store.soldAds[index], store);
                        },
                      );
                    },
                  ),
                ],
              );
          },
        ));
  }
}
