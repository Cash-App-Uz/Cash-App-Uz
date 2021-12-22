import 'package:cash_app/constants/imports.dart';

class SummaInputField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const SummaInputField({
    Key? key,
    required this.controller,
    required this.onChanged,
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
        controller: widget.controller,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.phone,
        obscureText: password,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: const InputDecoration(
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
