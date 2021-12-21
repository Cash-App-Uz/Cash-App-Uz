import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:cash_app/core/paths.dart';
import 'package:cash_app/services/firebase_crud.dart';
import 'package:cash_app/services/storage_service.dart';

class CreatBudgetPage extends StatefulWidget {
  const CreatBudgetPage({Key? key}) : super(key: key);
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreatBudgetPage> {
  String activeCategory = categories[0]['name'];
  String icon = categories[0]['icon'];
  TextEditingController budgetName = TextEditingController();
  TextEditingController budgetPrice = TextEditingController();
  final MyStorage _myStorage = MyStorage();
  final _api = Api();

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
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: getWidth(10.0),
                blurRadius: getWidth(3.0),
                // changes position of shadow
              ),
            ]),
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
                        "Chiqim Xarajatlari",
                        style: TextStyle(
                          fontSize: getWidth(20.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
                    icon = categories[index]['icon'];
                    activeCategory = categories[index]['name'];
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
                    height: getHeight(186.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: getWidth(2.0),
                            color: activeCategory == categories[index]['name']
                                ? Colors.deepOrangeAccent
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
                              width: getWidth(80.0),
                              height: getWidth(80.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.asset(
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
            padding:
                EdgeInsets.only(left: getWidth(20.0), right: getWidth(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xarajat tasnifi",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: getWidth(13.0),
                      color: const Color(0xff67727d)),
                ),
                TextField(
                  controller: budgetName,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: getWidth(17.0),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Nima uchun xarajat qildingiz...",
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: getHeight(20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (size.width - getWidth(140.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Xarajat miqdori",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: getWidth(13.0),
                                color: const Color(0xff67727d)),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: budgetPrice,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: getWidth(17.0),
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            decoration: const InputDecoration(
                                hintText: "Qancha xarajat qildingiz?",
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
              Map<String, dynamic> data2 = {};
              data2["type"] = "outcome";
              data2["category"] = activeCategory;
              data2["icon"] = icon;
              data2["amount"] = num.parse(budgetPrice.text);
              data2["cause"] = budgetName.text;
              data2["time"] = FieldValue.serverTimestamp();
              await _api.addDocument(data2, Paths().expenses);
              _myStorage.money = _myStorage.money - num.parse(budgetPrice.text);
              await _api.updateDocument(
                {"money": _myStorage.money},
                _myStorage.name,
                Paths().userInfo,
              );
              budgetPrice.clear();
            },
          )
        ],
      ),
    );
  }

  static const List categories = [
    {"name": "Telefon to'lovlari", "icon": "assets/images/phone.jpg"},
    {"name": "Yoqilg'i", "icon": "assets/images/auto.png"},
    {"name": "Yo'lkira xaqqi", "icon": "assets/images/bus.png"},
    {"name": "Savdo", "icon": "assets/images/shop.png"},
    {"name": "Kredit", "icon": "assets/images/bank.png"},
    {"name": "Komunal To'lov", "icon": "assets/images/cash.png"},
    {"name": "Xayriya", "icon": "assets/images/charity.png"},
    {"name": "Ovqatlanish", "icon": "assets/images/eating.png"},
    {"name": "Sovg'a", "icon": "assets/images/gift.png"}
  ];
}
