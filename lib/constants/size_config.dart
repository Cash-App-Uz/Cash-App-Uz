import 'package:cash_app/constants/imports.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;

  return (inputHeight / 812.0) * screenHeight;
}

double getWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;

  return (inputWidth / 375.0) * screenWidth;
}
