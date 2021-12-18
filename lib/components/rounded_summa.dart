
import 'package:cash_app/constants/imports.dart';

class SummaInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  SummaInputField({
    Key? key,
  required   this.onChanged,
  }) : super(key: key);

  @override
  State<SummaInputField> createState() => _SummaInputFieldState();
}

class _SummaInputFieldState extends State<SummaInputField> {
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
          hintText: "Sizdagi bor pulni kiriting",
          icon: Icon(
            Icons.monetization_on,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
