import 'package:app_vida_saludable/src/pages/bottom_bar/bottom_bar_controller.dart';
import 'package:app_vida_saludable/src/pages/home/home_pages.dart';
import 'package:app_vida_saludable/src/pages/informations/informations_pages.dart';
import 'package:app_vida_saludable/src/pages/settins/settings_page.dart';
import 'package:app_vida_saludable/src/pages/statistics/statistics_page.dart';
import 'package:app_vida_saludable/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';

class BottomBarPage extends StatelessWidget {

  BottomBarController con = Get.put(BottomBarController());
  // User user = User.fronJson(GetStorage().read('User') ?? {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
          index: con.indexTab.value,
          children: [
            HomePage(),
            StatisticsPage(),
            InformationsPage(),
            SettingsPage()
          ],
        ))
    );
  }

  Widget _bottomBar() {
    return Obx(()=> CustomAnimatedBottomBar(
        containerHeight: 60,
        backgroundColor: Colors.indigo,
        itemCornerRadius: 15,
        curve: Curves.easeIn,
        selectedIndex: con.indexTab.value,
        onItemSelected: (index) => con.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.analytics),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.feed),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          )
        ]
    ));
  }
}