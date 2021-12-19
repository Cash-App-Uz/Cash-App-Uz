import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/services/firebase_crud.dart';
import 'package:cash_app/services/storage_service.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String ismlogin;
  const HomePage(this.ismlogin);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController controllerTab;

  // late DocumentSnapshot<Map<String, dynamic>> userInfoMain;/
  bool isLoading = true;
  final Api _api = Api();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
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
    return  Scaffold(
            appBar: buildAppBar(widget.ismlogin),
            body: SizedBox.expand(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      appBarBottomSection(controllerTab, 1000),
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
                    title: Text('Asosiy'),
                    icon: Icon(Icons.home),
                    inactiveColor: _secondaryColor,
                    activeColor: _primaryColor),
                BottomNavyBarItem(
                    title: Text('Kirim'),
                    icon: Icon(Icons.attach_money_rounded),
                    inactiveColor: _secondaryColor,
                    activeColor: _primaryColor),
                BottomNavyBarItem(
                    title: Text('Chiqim'),
                    icon: Icon(Icons.money_off_csred_outlined),
                    inactiveColor: _secondaryColor,
                    activeColor: _primaryColor),
                BottomNavyBarItem(
                    title: Text('Profil'),
                    icon: Icon(Icons.person),
                    inactiveColor: _secondaryColor,
                    activeColor: _primaryColor),
              ],
            ),
          )
       ;
  }

  /// Main Body
  Expanded _mainBody() {
    return Expanded(
      child: TabBarView(
        controller: controllerTab,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TushumWidget(
                  budgetInfo: "benzinga",
                  budgetName: "yoqilg'i",
                  icon:
                      "https://previews.123rf.com/images/ladyminnie/ladyminnie1111/ladyminnie111100002/11164518-view-from-income-and-outcome-of-the-finances-isolated-on-white.jpg",
                  budgetPrice: 349,
                  time: DateTime.now(),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: _api.getDocuments("kassa/${widget.ismlogin}/chiqimlar"),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {

                    return const Center(child: LoadingIndicator(),);
                  }
                  if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.none) {
                    return const Center(child: Text("Internetingizni tekshiring!"),);
                  }
                  // print(snapshot.data);
                  List<IoModel> data =
                      snapshot.data!.map((e) => IoModel.fromJson(e)).toList();
                  return ListView.separated(
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 10.0,
                      );
                    },
                    itemBuilder: (context, index) {
                      return TushumWidget(
                        budgetInfo: data[index].cause,
                        budgetName: data[index].category,
                        icon:data[index].icon,
                        budgetPrice: data[index].amount,
                        time: DateTime.now(),
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                }),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            physics: BouncingScrollPhysics(),
            child: FutureBuilder(
                future: _api.getDocuments("kassa/${widget.ismlogin}/kirimlar"),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {

                    return const Center(child: LoadingIndicator(),);
                  }
                  if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.none) {
                    return const Center(child: Text("Internetingizni tekshiring!"),);
                  }
                  // print(snapshot.data);
                  List<IoModel> data =
                      snapshot.data!.map((e) => IoModel.fromJson(e)).toList();
                  return ListView.separated(
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: 10.0,
                      );
                    },
                    itemBuilder: (context, index) {
                      return TushumWidget(
                        budgetInfo: data[index].cause,
                        budgetName: data[index].category,
                        icon:data[index].icon,
                        budgetPrice: data[index].amount,
                        time: DateTime.now(),
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
