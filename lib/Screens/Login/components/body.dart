// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:cash_app/constants/imports.dart';

class Body extends StatelessWidget {
  String? ismLogin;
  String? passwordLogin;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "KIRISH",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Ism",
              onChanged: (value) {
                ismLogin = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                passwordLogin = value;
              },
            ),
            RoundedButton(
              text: "KIRISH",
              press: () async {
                try {
                  DocumentSnapshot userInfo = await _firestore
                      .collection("users")
                      .doc("$ismLogin")
                      .get();
                  if (userInfo['name'] == ismLogin &&
                      userInfo['password'] == passwordLogin) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(ismLogin!),
                        ),
                        (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Parol noto'g'ri"),
                        action: SnackBarAction(
                          label: 'ok',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Bunday foydalanuvchi mavjud emas'),
                      action: SnackBarAction(
                        label: 'ok',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
