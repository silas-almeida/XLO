import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:xlo_mobx2/screens/ad/components/bottom_bar.dart';
import 'package:xlo_mobx2/screens/ad/components/description_panel.dart';
import 'package:xlo_mobx2/screens/ad/components/location_panel.dart';
import 'package:xlo_mobx2/screens/ad/components/main_panel.dart';
import 'package:xlo_mobx2/screens/ad/components/user_panel.dart';

class AdScreen extends StatelessWidget {
  AdScreen(this.ad);
  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Anúncio'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: ad.images
                      .map((imageUrl) => CachedNetworkImageProvider(imageUrl))
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainPanel(ad),
                    Divider(color: Colors.grey[500]),
                    DescriptionPanel(ad),
                    Divider(color: Colors.grey[500]),
                    LocationPanel(ad),
                    Divider(color: Colors.grey[500]),
                    UserPanel(ad),
                    SizedBox(
                      height: ad.status == AdStatus.PENDING ? 16 : 114,
                    ),
                  ],
                ),
              )
            ],
          ),
          BottomBar(ad),
        ],
      ),
    );
  }
}
