import 'package:cash_app/constants/imports.dart';
import 'package:cash_app/services/storage_service.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

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
      home: MyStorage().name == "" ? WelcomeScreen() : HomePage(),
    );
  }
}
