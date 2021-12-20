// import 'package:flutter_icons/flutter_icons.dart';

import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/constants/size_config.dart';

class KirimPage extends StatefulWidget {
  String ismlogin;

  static TextEditingController budgetName = TextEditingController();

  KirimPage(this.ismlogin);
  @override
  _KirimPageState createState() => _KirimPageState();
}

class _KirimPageState extends State<KirimPage> {
  String activeCategory = categories[0]['name'];
  String icon = categories[0]['icon'];
  TextEditingController budgetPrice = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentSnapshot userInfo;

  @override
  void initState() {
    _firestore.collection("users").doc(widget.ismlogin).get().then((value) {
      userInfo = value;
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: getHeight(30.0),
                  right: getWidth(20.0),
                  left: getWidth(20.0),
                  bottom: getHeight(20.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Kelgan Mablag'lar",
                        style: TextStyle(
                            fontSize: getWidth(20.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: getWidth(20.0),
                right: getWidth(20.0),
                top: getHeight(20.0)),
            child: Text(
              "Kategoriyani tanlang",
              style: TextStyle(
                  fontSize: getWidth(16.0),
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: getHeight(30.0),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = categories[index]['name'];
                    icon = categories[index]['icon'];
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getWidth(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: getWidth(10.0),
                    ),
                    width: getWidth(150.0),
                    height: getHeight(180.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == categories[index]['name']
                                ? const Color(0xFFFF3378)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getWidth(25.0),
                          right: getWidth(25.0),
                          top: getHeight(20.0),
                          bottom: getHeight(20.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: getWidth(60.0),
                              height: getWidth(60.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.network(
                                  categories[index]['icon'],
                                  width: getWidth(60.0),
                                  height: getWidth(60.0),
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Text(
                            categories[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getWidth(18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          SizedBox(
            height: getHeight(50.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Qayerdan keldi",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: getWidth(13.0),
                      color: const Color(0xff67727d)),
                ),
                TextField(
                  controller: KirimPage.budgetName,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: getWidth(17.0),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Nima sababdan keldi...",
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: getHeight(20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pul miqdori",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: getWidth(13.0),
                                color: const Color(0xff67727d)),
                          ),
                          TextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: budgetPrice,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: getWidth(17.0),
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            decoration: const InputDecoration(
                                hintText: "Qancha pul keldi?",
                                border: InputBorder.none),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          RoundedButton(
            text: "Saqlash",
            press: () async {
              getInfo();
              try {
                Map<String, dynamic> data2 = Map();
                data2["type"] = "income";
                data2["category"] = activeCategory;
                data2["icon"] = icon;
                data2["amount"] = budgetPrice.text;
                data2["cause"] = KirimPage.budgetName.text;
                data2["time"] = FieldValue.serverTimestamp();
                await _firestore
                    .collection("kassa")
                    .doc(widget.ismlogin)
                    .collection("expenses")
                    .add(data2)
                    .then(
                      (value) => debugPrint("Data is successfully added!"),
                    );
              } catch (e) {
                debugPrint(e.toString());
              }
              num result = userInfo["pul"] + int.parse(budgetPrice.text);
              await _firestore.collection("users").doc(widget.ismlogin).update({
                "pul": result,
              }).then(
                (value) => debugPrint("Update! "),
              );
            },
          )
        ],
      ),
    );
  }

  getInfo() async {
    _firestore.collection("users").doc(widget.ismlogin).get().then((value) {
      userInfo = value;
      setState(() {});
    });
  }

  static const List categories = [
    {
      "name": "Oylik Maosh",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/cash.png"
    },
    {
      "name": "Qarz",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/charity.png"
    },
    {
      "name": "Investitsiya",
      "icon":
          "https://www.pngkey.com/png/detail/416-4162504_investment-icon-png-staysafeonline-org.png"
    },
    {
      "name": "Biznes Foyda",
      "icon": "https://cdn-icons-png.flaticon.com/512/747/747783.png"
    },
  ];
}
