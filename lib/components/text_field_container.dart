import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/constants/size_config.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: getHeight(10.0),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(20.0),
        vertical: getHeight(5.0),
      ),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
