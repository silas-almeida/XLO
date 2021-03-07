import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:xlo_mobx2/helpers/extensions.dart';
import 'package:xlo_mobx2/screens/ad/ad_screen.dart';
import 'package:xlo_mobx2/screens/create/create_screen.dart';
import 'package:xlo_mobx2/stores/myads_store.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.ad, this.store);

  final Ad ad;
  final MyAdsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdScreen(ad)));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: ad.images.isEmpty
                      ? 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQMAAADCCAMAAAB6zFdcAAAAJFBMVEXw8PDZ2dnb29vs7Ozu7u7a2trk5OTh4eHn5+ff39/m5ubW1tZgd3wLAAADEUlEQVR4nO2d7XaCMAxAgZaPsvd/38nUUdq0eATElHvPfjhFpHehSYq6qgIAAAAAAAAAAAAAAAAAAAAAAAAAAAD4UszP2ZizFVSmPhsc4AAHOMABDnCAAxzgAAc4wIEqB4f3ygocVPZYKg0OjgYHOJjAAQ4mVDswY+9c3w122ysqdjC49rFF0216RbUOrPNrm3bY8IpaHdgm2GpDKCh1ECnYIkGpAxcpqOu3TwedDgZBQe3W923FDKLTgRQGdT2u7rsTPal0kFhiWA+EVhyfSged7GC1ohxlTyod9AkHawc/nULCzKnSgTwdrGaGv5m0je9X6SAuDl5ycFcX1xEqHaTiIH/wjx23UX5U6SAxH/zk+8fns/rwAZUOxBJJPNXF/YZjVOlA6BbEP/CCOXjC/KjSgXwytNljt+28ZbChTgdWcpBvHP26qlk+pNPBVPGFNPkZcXH6LJOoUgdxudzkj3wpbRkIWh2EU8KKgrCkWLSYah1Ugx/d+ZQQZ9PF/KnXwS2+HwvLTb961FFl6UvT7OCWH8wwDi8csomur/sD1e3gVYR6wiuULuHAtOE+az8/XsKBWFbO+fESDiQFXiBcwUFi+dE9C8sLOEh0mXNxfQEHQm9xOQep1ceCHQxBD51YdCrYwdRFLJuH1AJsqQ7Ge9z7EpJhUKaDuZP0JCTDoEQHxh/tv4TMO8CLc2CDevg5MaYuTRbowEQJ8C7BSt1SmQ6kavhPQiYMCnMgj3RMl8nFOUgOtEu+WaM0Bzad/br0Q0U4sM/3mGXHWbAD0zc33LSenA33gh14l5DfV6DbwYZxl+Ig3QVdxsFunwHV6yBb9lzEwdupsBwHuQbgIg52SgmaHeyVEhQ72PdrAVQ62C8l6HWwrwKVDrrmiZt+3P3GfPPxy+Om87dt5nv/n9Zc6ZrrKjjAwQQOcDCBAxxMKHBgzbFEH4b4QgfN0Shw8HFwgAMc4AAHOMABDnCAAxzg4IsdxJ/H/Czf8L+J2sOb5Tz575L4kISzOVsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQJJfX084wDL8aVYAAAAASUVORK5CYII='
                      : ad.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ad.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ad.price.formattedMoney(),
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      Text(
                        '${ad.views} visitas',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
              PopupMenuButton<MenuChoice>(
                  icon: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.purple,
                  ),
                  onSelected: (choice) {
                    print(choice.index);
                    switch (choice.index) {
                      case 0:
                        editAd(context);
                        break;
                      case 1:
                        soldAd(context);
                        break;
                      case 2:
                        deleteAd(context);
                        break;
                    }
                  },
                  itemBuilder: (_) {
                    return choices
                        .map((choice) => PopupMenuItem<MenuChoice>(
                            value: choice,
                            child: Row(
                              children: [
                                Icon(
                                  choice.iconData,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  choice.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.purple,
                                  ),
                                )
                              ],
                            )))
                        .toList();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateScreen(ad: ad),
      ),
    );
    if (success != null && success) {
      store.refresh();
    }
  }

  void soldAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Vendido'),
        content: Text('Confirmar a venda de ${ad.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Não',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.soldAd(ad);
            },
            child: const Text(
              'Sim',
              style: TextStyle(color: Colors.red),
            ),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir'),
        content: Text('Confirmar a exclusão de ${ad.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Não',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteAd(ad);
            },
            child: const Text(
              'Sim',
              style: TextStyle(color: Colors.red),
            ),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
