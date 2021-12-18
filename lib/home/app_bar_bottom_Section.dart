
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
  final oCcy = NumberFormat("#,##0", "en_US");


Ink appBarBottomSection(TabController controllerTab, userInfoMain) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      decoration: BoxDecoration(
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
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                oCcy.format(userInfoMain),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                  height: 0.9,
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 46,
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
                tabs: [
                  Tab(text: 'Barchasi'),
                  Tab(text: 'Chiqim'),
                  Tab(text: 'Tushum'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  