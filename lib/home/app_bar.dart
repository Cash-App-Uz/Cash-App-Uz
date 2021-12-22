import 'package:cash_app/Screens/about_us/about_us.dart';
import 'package:cash_app/constants/colors.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(String name, BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: kCategoryWidget,
    title: Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: getWidth(20.0),
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: getWidth(16.0)),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutUs(),
            ),
          ),
          child: CircleAvatar(
            radius: getWidth(16),
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                'assets/images/about_us.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
