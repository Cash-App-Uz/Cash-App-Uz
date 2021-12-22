import 'package:cash_app/constants/colors.dart';
import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:cash_app/core/paths.dart';
import 'package:cash_app/services/firebase_crud.dart';
import 'package:cash_app/services/storage_service.dart';

class KirimPage extends StatefulWidget {
  static TextEditingController budgetName = TextEditingController();

  const KirimPage({Key? key}) : super(key: key);
  @override
  _KirimPageState createState() => _KirimPageState();
}

class _KirimPageState extends State<KirimPage> {
  String activeCategory = categories[0]['name'];
  String icon = categories[0]['icon'];
  TextEditingController budgetPrice = TextEditingController();
  final Api _api = Api();
  final _myStorage = MyStorage();
  @override
  void initState() {
    super.initState();
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
                    height: getHeight(186.0),
                    decoration: BoxDecoration(
                        color: kCategoryWidget,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == categories[index]['name']
                                ? kAppBar
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.01),
                            spreadRadius: getWidth(10.0),
                            blurRadius: getWidth(3.0),
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
                          SizedBox(
                              width: getWidth(60.0),
                              height: getWidth(60.0),
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
                              color: kWhite,
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
                      width: (size.width - getWidth(140.0)),
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
                              border: InputBorder.none,
                            ),
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
            press: addIcome,
          )
        ],
      ),
    );
  }

  Future addIcome() async {
    IoModel data = IoModel(
      category: activeCategory,
      amount: num.parse(budgetPrice.text),
      cause: KirimPage.budgetName.text,
      type: "income",
      time: DateTime.now(),
      icon: icon,
    );

    _myStorage.money = _myStorage.money + num.parse(budgetPrice.text);
    await _api.addDocument(data.toJson(), Paths().expenses);
    await _api.updateDocument(
      {"money": _myStorage.money},
      _myStorage.name,
      Paths().userInfo,
    );
    budgetPrice.clear();
    KirimPage.budgetName.clear();
  }

  static const List categories = [
    {"name": "Oylik Maosh", "icon": "assets/images/cash.png"},
    {"name": "Qarz", "icon": "assets/images/charity.png"},
    {"name": "Investitsiya", "icon": "assets/images/investment.png"},
    {"name": "Biznes Foyda", "icon": "assets/images/business.png"},
  ];
}
