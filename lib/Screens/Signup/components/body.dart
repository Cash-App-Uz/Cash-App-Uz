import 'package:cash_app/constants/size_config.dart';
import 'package:cash_app/core/paths.dart';
import 'package:cash_app/services/firebase_crud.dart';
import 'package:cash_app/services/storage_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cash_app/constants/imports.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool tekshir = true;
  final TextEditingController controller = TextEditingController(text: '0');
  var _verificationId;
  bool? isSignUp;
  var _otpController;
  final _api = Api();

  String? ism;

  String? phone;

  String? password;

  int? summa;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _myStorage = MyStorage();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: tekshir
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
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
                      setState(() {});
                      isSignUp = (phone!.length == 9) &&
                          (ism!.length > 3) &&
                          (password!.length >= 4);
                    },
                  ),
                  RoundedPhoneInputField(
                    hintText: "Misol: 912077978",
                    onChanged: (value) {
                      phone = value;
                      setState(() {});
                      isSignUp = (phone!.length == 9) &&
                          (ism!.length > 3) &&
                          (password!.length >= 4);
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      password = value;

                      setState(() {});
                      isSignUp = (phone!.length == 9) &&
                          (ism!.length > 3) &&
                          (password!.length >= 4);
                    },
                  ),
                  RoundedButton(
                    text: "Ro'yhatdan O'tish",
                    press: isSignUp == true
                        ? () async {
                            if (await _api.exists(Paths().userInfo, ism)) {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: "+998$phone",
                                  verificationCompleted:
                                      (PhoneAuthCredential e) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (verificationId, resendToken) {
                                    _verificationId = verificationId;
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {});
                              if (tekshir) {
                                setState(() {
                                  tekshir = false;
                                });
                              } else {
                                setState(() {
                                  tekshir = true;
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Bunday foydalanuvchi mavjud',
                                  ),
                                  action: SnackBarAction(
                                    label: 'ok',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        : null,
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
            const Text(
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
                setState(() {});
              },
            ),
            SummaInputField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  summa = int.parse(value.isEmpty ? '0' : value);
                });
              },
            ),
            controller.text.isNotEmpty
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
                            .collection("users/")
                            .doc("$ism")
                            .set(data1)
                            .then(
                              (value) =>
                                  debugPrint("Data is successfully added!"),
                            );
                        _myStorage.money = summa!;
                        _myStorage.name = ism!;
                        _myStorage.password = password!;
                        _myStorage.phone = phone!;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
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
                : const Center(),
          ],
        ),
      ),
    );
  }
}
