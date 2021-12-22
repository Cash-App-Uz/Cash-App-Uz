import 'package:cash_app/core/paths.dart';
import 'package:cash_app/models/user_model.dart';
import 'package:cash_app/services/firebase_crud.dart';
import 'package:cash_app/services/storage_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cash_app/constants/imports.dart';

class Body extends StatelessWidget {
  String ismLogin = '';
  String passwordLogin = '';
  final MyStorage _myStorage = MyStorage();
  final _api = Api();

  Body({Key? key}) : super(key: key);

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
                if (ismLogin.length >= 4 && passwordLogin.length >= 4) {
                  try {
                    var data =
                        await _api.getDocumentById(ismLogin, Paths().userInfo);
                    if (data['name'] == ismLogin &&
                        data['password'] == passwordLogin) {
                      _myStorage.money = data['money'];
                      _myStorage.name = data['name'];
                      _myStorage.password = data['password'];
                      _myStorage.phone = data['phone'];
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
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
                    print(e);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          const Text("Parol va Ism 4 harfdan kam bo'lmasin!"),
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
