import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx2/screens/account/account_screen.dart';
import 'package:xlo_mobx2/screens/create/create_screen.dart';
import 'package:xlo_mobx2/screens/home/home_screen.dart';
import 'package:xlo_mobx2/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction(
      (_) => pageStore.page,
      (page) => pageController.jumpToPage(page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.purple,
          ),
          AccountScreen(),
        ],
      ),
    );
  }
}
