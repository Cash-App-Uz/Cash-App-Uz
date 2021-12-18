import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            body: Center(
              child: SpinKitSpinningLines(
                size: 70.0,
                color: Colors.deepOrangeAccent,
              ),
            ),
          );
  }
}