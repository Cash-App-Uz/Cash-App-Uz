import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/services/storage_service.dart';

void main() async {
  await MyPref().init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyPref().name == "" ? WelcomeScreen() : HomePage(MyPref().name),
    );
  }
}
