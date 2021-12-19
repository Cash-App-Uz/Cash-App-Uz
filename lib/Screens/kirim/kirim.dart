// import 'package:flutter_icons/flutter_icons.dart';

import 'package:cash_app/constants/imports.dart';

class KirimPage extends StatefulWidget {
  String ismlogin;

  static TextEditingController budgetName = TextEditingController();

  KirimPage(this.ismlogin);
  @override
  _KirimPageState createState() => _KirimPageState();
}

class _KirimPageState extends State<KirimPage> {
  String activeCategory = categories[0]['name'];
  TextEditingController budgetPrice = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentSnapshot userInfo;
  late String icon;
  @override
  void initState() {
    _firestore
        .collection("users")
        .doc("${widget.ismlogin}")
        .get()
        .then((value) {
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
              padding: const EdgeInsets.only(
                  top: 30, right: 20, left: 20, bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Kelgan Mablag'lar",
                        style: TextStyle(
                            fontSize: 20,
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              "Kategoriyani tanlang",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == categories[index]['name']
                                ? Color(0xFFFF3378)
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
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.network(
                                  categories[index]['icon'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Text(
                            categories[index]['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Qayerdan keldi",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: KirimPage.budgetName,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Nima sababdan keldi...",
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pul miqdori",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: budgetPrice,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            decoration: InputDecoration(
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
