import 'package:cash_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: SpinKitSpinningLines(
        size: getHeight(70.0),
        color: Colors.deepOrangeAccent,
      ),
    );
  }
}
