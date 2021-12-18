import 'package:flutter_svg/flutter_svg.dart';
import 'package:cash_app/constants/imports.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool tekshir = true;
  var _verificationId;

  var _otpController;

  String? ism;

  String? phone;

  String? password;

  int? summa;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: tekshir
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "RO'YHATDAN\nO'TISH",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    hintText: "Ism",
                    onChanged: (value) {
                      ism = value;
                    },
                  ),
                  RoundedPhoneInputField(
                    hintText: "Misol: 912077978",
                    onChanged: (value) {
                      phone = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedButton(
                    text: "Ro'yhatdan O'tish",
                    press: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+998" + "$phone",
                          verificationCompleted: (PhoneAuthCredential e) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (verificationId,  resendToken) {
                            _verificationId = verificationId;
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {});
                      if (tekshir) {
                        setState(() {
                          tekshir = false;
                        });
                      } else {
                        setState(() {
                          tekshir = true;
                        });
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              )
            : smsVerify(),
      ),
    );
  }

  Background smsVerify() {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SMS ni\nTASDIQLASH",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedSmsCodeField(
              onChanged: (value) {
                _otpController = value;
              },
            ),
            SummaInputField(
              onChanged: (value) {
                setState(() {
                  summa = int.parse(value);
                });
              },
            ),
            summa != null
                ? RoundedButton(
                    text: "Tasdiqlash",
                    press: () async {
                      try {
                        final AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: _verificationId,
                                smsCode: _otpController);

                        //______________//___________________//
                        Map<String, dynamic> data1 = Map();
                        data1["name"] = ism;
                        data1["phone"] = phone;
                        data1["password"] = password;
                        data1["pul"] = summa;

                        await _firestore
                            .collection("users")
                            .doc("$ism")
                            .set(data1)
                            .then(
                              (value) =>
                                  debugPrint("Data is successfully added!"),
                            );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(ism!),
                            ),
                            (route) => false);
                      } catch (e) {
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
                    })
                : Center(),
          ],
        ),
      ),
    );
  }
}
