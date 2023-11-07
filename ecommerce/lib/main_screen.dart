import 'package:ecommerce/controllers/mainscreen_provider.dart';
import 'package:ecommerce/views/shared/bottom_nav.dart';
import 'package:ecommerce/views/ui/cart_page.dart';
import 'package:ecommerce/views/ui/favorite_page.dart';
import 'package:ecommerce/views/ui/home_page.dart';
import 'package:ecommerce/views/ui/product_by_cat.dart';
import 'package:ecommerce/views/ui/profile.dart';
import 'package:ecommerce/views/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  List<Widget> pageList = [
    HomePage(),
    SearchPage(),
    Favorites(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
