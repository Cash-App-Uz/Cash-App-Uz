import 'package:cash_app/constants/colors.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChiqimWidget extends StatelessWidget {
  ChiqimWidget(
      {Key? key,
      required this.icon,
      required this.budgetName,
      required this.budgetInfo,
      required this.budgetPrice,
      required this.time})
      : super(key: key);

  final String icon;
  final String budgetName;
  final String budgetInfo;
  final num budgetPrice;
  final DateTime time;
  final NumberFormat _numberFormat = NumberFormat(",###");
  final format = DateFormat('dd-MM-yyyy HH:MM');

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(30.0), vertical: getHeight(16.0)),
      decoration: BoxDecoration(
        color: const Color(0xffB91646),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 2),
      ),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: getWidth(80.0),
                height: getWidth(80.0),
                child: Image.asset(icon),
              ),
            ],
          ),
          SizedBox(
            width: getWidth(30.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _numberFormat.format(budgetPrice),
                style: TextStyle(
                  color: kWhite,
                  fontSize: getWidth(20.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: getHeight(12.0),
              ),
              Text(
                budgetName,
                style: TextStyle(
                  color: kWhite,
                  fontSize: getWidth(20.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: getHeight(10.0),
              ),
              Text(
                format.format(time),
                style: TextStyle(
                  color: kWhite,
                  fontSize: getWidth(12.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: getHeight(10.0),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Text(
                  budgetInfo,
                  style: TextStyle(
                    color: kWhite,
                    fontSize: getWidth(12.0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
