import 'package:get_storage/get_storage.dart';

class MyPref {
  Future<void> init() async {
    await GetStorage.init();
  }

  GetStorage box = GetStorage();
  var a = GetStorage().read("name");
  String get name => box.read("name");

  int get password => box.read("password");
  set name(String name) {
    box.write("name", name);
  }

  set password(int password) {
    box.write("password", password);
  }

  void delete() {
    box.remove("password");
    box.remove("name");
  }
}
