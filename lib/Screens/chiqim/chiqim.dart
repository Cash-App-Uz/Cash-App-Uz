import 'package:cash_app/constants/imports.dart';

class CreatBudgetPage extends StatefulWidget {
  String ismlogin;
  CreatBudgetPage(this.ismlogin);
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreatBudgetPage> {
  String activeCategory = categories[0]['name'];
  late DocumentSnapshot userInfo;
  TextEditingController budgetName = TextEditingController();
  TextEditingController budgetPrice = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String icon;

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
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 20, left: 20, bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Chiqim Xarajatlari",
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
          const SizedBox(
            height: 20,
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
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 2,
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
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Xarajat tasnifi",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: budgetName,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Nima uchun xarajat qildingiz...",
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Xarajat miqdori",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: budgetPrice,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                fontSize: 17,
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
              getInfo();
              Map<String, dynamic> data2 = Map();
              data2["type"] = "outcome";
              data2["category"] = activeCategory;
              data2["icon"] = icon;
              data2["amount"] = budgetPrice.text;
              data2["cause"] = budgetName.text;
              data2["time"] = FieldValue.serverTimestamp();
              await _firestore
                  .collection("kassa")
                  .doc(widget.ismlogin)
                  .collection("expenses")
                  .add(data2)
                  .then(
                    (value) => debugPrint("Data is successfully added!"),
                  );

              num result = userInfo["pul"] - int.parse(budgetPrice.text);
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
      "name": "Telefon to'lovlari",
      "icon":
          "https://png.pngtree.com/png-vector/20190121/ourlarge/pngtree-vector-phone-cell-icon-png-image_332938.jpg"
    },
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
