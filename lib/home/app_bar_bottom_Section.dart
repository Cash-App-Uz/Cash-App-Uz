import 'package:cash_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("#,##0", "en_US");

Ink appBarBottomSection(TabController controllerTab, userInfoPul) {
  return Ink(
    padding: EdgeInsets.symmetric(horizontal: getWidth(50.0)),
    width: 500.0,
    decoration: const BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
    ),
    child: Column(
      children: <Widget>[
        Text(
          'Hisobingiz :',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: getWidth(20.0),
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        SizedBox(
          height: getHeight(20.0),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              oCcy.format(userInfoPul),
              style: TextStyle(
                color: Colors.white,
                fontSize: getWidth(45.0),
                fontWeight: FontWeight.w600,
                height: .9,
              ),
            ),
            SizedBox(
              height: getHeight(8.0),
            ),
          ],
        ),
        SizedBox(
          height: getHeight(8.0),
        ),
        Container(
          height: getHeight(46.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TabBar(
              isScrollable: true,
              controller: controllerTab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.amber,
              indicator: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              tabs: const [
                Tab(text: 'Barchasi'),
                Tab(text: 'Chiqim'),
                Tab(text: 'Tushum'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getHeight(20.0),
        ),
      ],
    ),
  );
}
