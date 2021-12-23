import 'package:cash_app/constants/colors.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:cash_app/services/url_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  final UrlLaunch _launcher = UrlLaunch();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xffE2F4FF),
      appBar: AppBar(
        title: Text(
          "Mualliflar:",
          style: TextStyle(
            color: kCategoryWidget,
            fontSize: getWidth(20.0)
          ),
        ),
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
              _developerInfoCard(
                  "Samandar",
                  "Samandar_Jasurovich",
                  "+998 91 207 79 78",
                  "Github.com",
                  "Github",
                  context,
                  'https://github.com/jasurovich',
                  'assets/images/samandar.png'),
              _developerInfoCard(
                  "Diyorbek",
                  "DiyorbekDev",
                  "+998 97 907 97 79",
                  "Github.com",
                  "Github",
                  context,
                  'https://github.com/discoveruz',
                  'assets/images/diyorbek.jpg'),
              _developerInfoCard(
                  "Muhammad",
                  "MuhammadFazliddinov",
                  "+998 94 524 99 44",
                  "Behance.com",
                  "Behance.com",
                  context,
                  'https://www.behance.net/mohamedrec/',
                  "assets/images/Muhammad_aka.png"),
            ],
          ),
        ),
      ),
    );
  }

  Ink _developerInfoCard(
      ismi, telegram, telefon, github, network, context, web, image) {
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
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(5.0), vertical: 10.0),
              child: Ink(
                width: getWidth(140.0),
                height: getHeight(229.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                  color: Colors.cyan.shade100,
                  borderRadius: BorderRadius.circular(
                    getWidth(15.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: getWidth(10.0)),
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(5.0),
                      ),
                      RichText(
                        text: TextSpan(
                          text: telegram,
                          style: TextStyle(
                            color: const Color(0xff3366BB),
                            fontSize: getWidth(14.0),
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launcher.launchTelegram(telegram, context);
                            },
                        ),
                      )
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
                      RichText(
                        text: TextSpan(
                          text: telefon,
                          style: TextStyle(
                            color: const Color(0xff3366BB),
                            fontSize: getWidth(14.0),
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launcher.launchPhone(telefon, context);
                            },
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        network,
                        style: TextStyle(
                            color: const Color(0xffB8C5D0),
                            fontSize: getWidth(9.0),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getHeight(5.0),
                      ),
                      RichText(
                        text: TextSpan(
                          text: github,
                          style: TextStyle(
                            color: const Color(0xff3366BB),
                            fontSize: getWidth(14.0),
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launcher.launchWeb(web, context);
                            },
                        ),
                      )
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
