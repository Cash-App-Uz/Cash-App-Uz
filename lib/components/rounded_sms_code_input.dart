
import 'package:cash_app/constants/imports.dart';

class RoundedSmsCodeField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  RoundedSmsCodeField({
    Key? key,
  required   this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedSmsCodeField> createState() => _RoundedSmsCodeFieldState();
}

class _RoundedSmsCodeFieldState extends State<RoundedSmsCodeField> {
  bool password = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.phone,
        obscureText: password,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Sms Kodni kiriting",
          icon: Icon(
            Icons.sms_rounded,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
