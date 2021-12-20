import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/constants/size_config.dart';
import 'package:cash_app/services/firebase_crud.dart';
import 'package:cash_app/services/storage_service.dart';

class HomePage extends StatefulWidget {
  final String ismlogin;
  const HomePage(this.ismlogin, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController controllerTab;
  final Api _api = Api();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // DocumentSnapshot? userInfo;

  @override
  void initState() {
    // _firestore.collection("users").doc(widget.ismlogin).get().then((value) {
    //   userInfo = value;
    //   setState(() {});
    // });
    MyPref().init().whenComplete(() {
      MyPref().name = widget.ismlogin;
    });

    super.initState();
    controllerTab = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String type = "all";

  static const Color _primaryColor = Colors.deepPurpleAccent;
  static const Color _secondaryColor = Colors.deepOrangeAccent;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(widget.ismlogin),
      body: SizedBox.expand(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Column(
              children: <Widget>[
                appBarBottomSection(controllerTab, 100),
                _mainBody(),
              ],
            ),
            KirimPage(widget.ismlogin),
            CreatBudgetPage(widget.ismlogin),
            ProfilePage(widget.ismlogin),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: const Text('Asosiy'),
              icon: const Icon(Icons.home),
              inactiveColor: _secondaryColor,
              activeColor: _primaryColor),
          BottomNavyBarItem(
              title: const Text('Kirim'),
              icon: const Icon(Icons.attach_money_rounded),
              inactiveColor: _secondaryColor,
              activeColor: _primaryColor),
          BottomNavyBarItem(
              title: const Text('Chiqim'),
              icon: const Icon(Icons.money_off_csred_outlined),
              inactiveColor: _secondaryColor,
              activeColor: _primaryColor),
          BottomNavyBarItem(
              title: const Text('Profil'),
              icon: const Icon(Icons.person),
              inactiveColor: _secondaryColor,
              activeColor: _primaryColor),
        ],
      ),
    );
  }

  /// Main Body
  Expanded _mainBody() {
    return Expanded(
      child: TabBarView(
        controller: controllerTab,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(20.0), vertical: getHeight(30.0)),
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
              future: _api.getDocuments("kassa/${widget.ismlogin}/expenses"),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LoadingIndicator(),
                  );
                }
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text("Internetingizni tekshiring!"),
                  );
                }
                List<IoModel> data =
                    snapshot.data!.map((e) => IoModel.fromJson(e)).toList();
                return ListView.separated(
                  separatorBuilder: (_, __) {
                    return SizedBox(
                      height: getHeight(10.0),
                    );
                  },
                  itemBuilder: (context, index) {
                    return data[index].type == "income"
                        ? TushumWidget(
                            budgetInfo: data[index].cause,
                            budgetName: data[index].category,
                            icon: data[index].icon,
                            budgetPrice: data[index].amount,
                            time: data[index].time,
                          )
                        : ChiqimWidget(
                            budgetInfo: data[index].cause,
                            budgetName: data[index].category,
                            icon: data[index].icon,
                            budgetPrice: data[index].amount,
                            time: data[index].time,
                          );
                  },
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              },
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(20.0), vertical: getHeight(30.0)),
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: _api.getDocuments(
                    "kassa/${widget.ismlogin}/expenses", "outcome"),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LoadingIndicator(),
                    );
                  }
                  if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text("Internetingizni tekshiring!"),
                    );
                  }
                  List<IoModel> data =
                      snapshot.data!.map((e) => IoModel.fromJson(e)).toList();
                  return ListView.separated(
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: getHeight(10.0),
                      );
                    },
                    itemBuilder: (context, index) {
                      return ChiqimWidget(
                        budgetInfo: data[index].cause,
                        budgetName: data[index].category,
                        icon: data[index].icon,
                        budgetPrice: data[index].amount,
                        time: DateTime.now(),
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                }),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(20.0), vertical: getHeight(30.0)),
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: _api.getDocuments(
                    "kassa/${widget.ismlogin}/expenses", "income"),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LoadingIndicator(),
                    );
                  }
                  if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text("Internetingizni tekshiring!"),
                    );
                  }
                  List<IoModel> data =
                      snapshot.data!.map((e) => IoModel.fromJson(e)).toList();
                  return ListView.separated(
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: getHeight(10.0),
                      );
                    },
                    itemBuilder: (context, index) {
                      return TushumWidget(
                        budgetInfo: data[index].cause,
                        budgetName: data[index].category,
                        icon: data[index].icon,
                        budgetPrice: data[index].amount,
                        time: DateTime.now(),
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
