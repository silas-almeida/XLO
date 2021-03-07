import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:get_it/get_it.dart';
import 'package:xlo_mobx2/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx2/screens/myads/my_ads_screen.dart';
import 'package:xlo_mobx2/stores/user_manager_store.dart';
// import 'package:xlo_mobx2/stores/user_manager_store.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Minha Conta'),
          centerTitle: true,
        ),
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                height: 120,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            GetIt.I<UserManagerStore>().user.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            GetIt.I<UserManagerStore>().user.email,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        child: Text(
                          'Editar',
                          style: TextStyle(color: Colors.purple, fontSize: 16),
                        ),
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              ListTile(
                title: Text(
                  'Meus Anúncios',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MyAdsScreen()));
                },
              ),
              Divider(
                height: 4.0,
                color: Colors.grey[600],
              ),
              ListTile(
                title: Text('Favoritos',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
              Divider(
                height: 4.0,
                color: Colors.grey[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
