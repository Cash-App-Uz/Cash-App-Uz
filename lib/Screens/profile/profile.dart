import 'package:cash_app/constants/imports.dart';

class ProfilePage extends StatefulWidget {
  String ismlogin;
  ProfilePage(this.ismlogin);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? userInfo;
  bool isLoading = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _firestore.collection("users").doc(widget.ismlogin).get().then((value) {
      userInfo = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.82,
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: SizedBox(
                          height: size.height * 0.15,
                          width: size.width * 0.32,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: CircleAvatar(
                                  radius: size.width * 0.15,
                                  backgroundImage: const AssetImage(
                                      "assets/images/profile.png"),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  radius: size.width * 0.05,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        Text(
                          "Ism",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: userInfo!["name"],
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                          ),
                        ),
                        Text(
                          "Telefon raqam",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                        TextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: "+998" + userInfo!["phone"],
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                          ),
                        ),
                        Text(
                          "Parol",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                        TextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: userInfo!["password"],
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (nameController.text != "") {
                              await _firestore
                                  .collection("users")
                                  .doc(widget.ismlogin)
                                  .update({
                                "name": nameController.text,
                              }).then(
                                (value) => debugPrint("Update! "),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("Bo'sh joyni to'ldiring"),
                                  action: SnackBarAction(
                                    label: 'ok',
                                    onPressed: () {
                                    
                                    },
                                  ),
                                ),
                              );
                            }
                            if (phoneController.text.length == 9) {
                              await _firestore
                                  .collection("users")
                                  .doc(widget.ismlogin)
                                  .update({
                                "phone": phoneController.text,
                              }).then(
                                (value) => debugPrint("Update! "),
                              );
                            } else if (phoneController.text.length < 9 &&
                                phoneController.text.length > 9) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("Noto'g'ri raqam"),
                                  action: SnackBarAction(
                                    label: 'ok',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }
                            if (passwordController.text.length >= 4) {
                              await _firestore
                                  .collection("users")
                                  .doc(widget.ismlogin)
                                  .update({
                                "password": passwordController.text,
                              }).then(
                                (value) => debugPrint("Update! "),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("parol kam kiritildi"),
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
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Saqlash",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.045,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                const Icon(
                                  Icons.save_alt,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            width: size.width,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.08),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                                (route) => false);
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.045,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                const Icon(
                                  Icons.logout,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            width: size.width,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.deepOrangeAccent),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.08),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const LoadingIndicator());
  }
}
