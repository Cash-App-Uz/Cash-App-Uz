
import 'package:cash_app/constants/imports.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
  required  this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
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
          hintText: "Parol",
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  password = password ? password = false : password = true;
                });
              },
              icon: Icon(
                password ? Icons.visibility : Icons.visibility_off,
                color: kPrimaryColor,
              )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
