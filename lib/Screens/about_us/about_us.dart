import 'package:cash_app/constants/colors.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xffE2F4FF),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kCategoryWidget),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: getHeight(5.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _developerInfoCard("Samandar", "samandar_Jasurovich",
                  "+998 91 207 79 78", "Github.com"),
              _developerInfoCard("Samandar", "samandar_Jasurovich",
                  "+998 91 207 79 78", "Github.com"),
              _developerInfoCard("Samandar", "samandar_Jasurovich",
                  "+998 91 207 79 78", "Github.com"),
            ],
          ),
        ),
      ),
    );
  }

  Ink _developerInfoCard(ismi, telegram, telefon, github) {
    return Ink(
      width: getWidth(335.0),
      height: getHeight(220.0),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(
          getWidth(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(getWidth(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(5.0), vertical: 10.0),
              child: Ink(
                width: getWidth(140.0),
                height: getHeight(229.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade100,
                  borderRadius: BorderRadius.circular(
                    getWidth(15.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getHeight(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ismi,
                    style: TextStyle(
                        color: const Color(0xff79838B),
                        fontSize: getWidth(28.0),
                        fontWeight: FontWeight.w500),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telegram:",
                        style: TextStyle(
                            color: const Color(0xffB8C5D0),
                            fontSize: getWidth(9.0),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getHeight(5.0),
                      ),
                      Text(
                        telegram,
                        style: TextStyle(
                            color: const Color(0xff79838B),
                            fontSize: getWidth(14.0),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telefon:",
                        style: TextStyle(
                            color: const Color(0xffB8C5D0),
                            fontSize: getWidth(9.0),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getHeight(5.0),
                      ),
                      Text(
                        telefon,
                        style: TextStyle(
                            color: const Color(0xff79838B),
                            fontSize: getWidth(14.0),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GitHub:",
                        style: TextStyle(
                            color: const Color(0xffB8C5D0),
                            fontSize: getWidth(9.0),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getHeight(5.0),
                      ),
                      Text(
                        github,
                        style: TextStyle(
                            color: const Color(0xff79838B),
                            fontSize: getWidth(14.0),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
