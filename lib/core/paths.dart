import 'package:cash_app/services/storage_service.dart';

class Paths {
  static Paths? paths;
  Paths() {
    MyPref().init();
  }
  String? get name => MyPref().name;

  static String get userInfo => "users/" + paths!.name!;
  static String get income => "kassa/" + paths!.name! + "expenses/income";
  static String get outcome => "kassa/" + paths!.name! + "expenses/outcome";
  static String get expenses => "kassa/" + paths!.name! + "expenses";
}
