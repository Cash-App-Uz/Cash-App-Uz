import 'package:cash_app/services/storage_service.dart';

class Paths {
  String get userInfo => "users/" + MyStorage().name;
  String get income => "kassa/" + MyStorage().name + "/expenses/income";
  String get outcome => "kassa/" + MyStorage().name + "/expenses/outcome";
  String get expenses => "kassa/" + MyStorage().name + "/expenses";
}
