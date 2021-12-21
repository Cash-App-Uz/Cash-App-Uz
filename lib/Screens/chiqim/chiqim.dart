import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:cash_app/services/storage_service.dart';

class CreatBudgetPage extends StatefulWidget {
  const CreatBudgetPage({Key? key}) : super(key: key);
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreatBudgetPage> {
  String activeCategory = categories[0]['name'];
  String icon = categories[0]['icon'];
  late DocumentSnapshot userInfo;
  TextEditingController budgetName = TextEditingController();
  TextEditingController budgetPrice = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MyStorage _myStorage = MyStorage();

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
            height: getHeight(20.0),
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
              budgetPrice.clear();
              KirimPage.budgetName.clear();
              getInfo();
              Map<String, dynamic> data2 = Map();
              data2["type"] = "outcome";
              data2["category"] = activeCategory;
              data2["icon"] = icon;
              data2["amount"] = num.parse(budgetPrice.text);
              data2["cause"] = budgetName.text;
              data2["time"] = FieldValue.serverTimestamp();
              await _firestore
                  .collection("kassa")
                  .doc(_myStorage.name)
                  .collection("expenses")
                  .add(data2)
                  .then(
                    (value) => debugPrint("Data is successfully added!"),
                  );

              num result = userInfo["pul"] - int.parse(budgetPrice.text);
              await _firestore.collection("users").doc(_myStorage.name).update({
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
    _firestore.collection("users").doc(_myStorage.name).get().then((value) {
      userInfo = value;

      setState(() {});
    });
  }

  static const List categories = [
    {"name": "Telefon to'lovlari", "icon": "assets/images/"},
    {
      "name": "Yoqilg'i",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/auto.png"
    },
    {
      "name": "Yo'lkira xaqqi",
      "icon":
          "https://www.pngkit.com/png/detail/262-2625826_red-bus-icon-png-clipart-double-decker-bus.png"
    },
    {
      "name": "Savdo",
      "icon":
          "https://www.seekpng.com/png/detail/867-8674000_family-pack-family-shopping-icon.png"
    },
    {
      "name": "Kredit",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/bank.png"
    },
    {
      "name": "Komunal To'lov",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/cash.png"
    },
    {
      "name": "Xayriya",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/charity.png"
    },
    {
      "name": "Ovqatlanish",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/eating.png"
    },
    {
      "name": "Sovg'a",
      "icon":
          "https://raw.githubusercontent.com/sopheamen007/app.mobile.budget-tracker-app-ui/master/assets/images/gift.png"
    }
  ];
}
