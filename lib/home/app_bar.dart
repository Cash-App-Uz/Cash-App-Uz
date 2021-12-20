import 'package:cash_app/constants/size_config.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(String name) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.deepPurpleAccent,
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
          padding: EdgeInsets.only(right: getWidth(20.0)),
          child: GestureDetector(
            onTap: () => print('Profile Tapped'),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  