import 'package:get_storage/get_storage.dart';

class MyStorage {
  GetStorage box = GetStorage();
  String get name => box.read("name") ?? '';
  String get password => box.read("password") ?? '';
  int get money => box.read('money') ?? 0;
  String get phone => box.read('phone') ?? '';

  set name(String name) {
    box.write("name", name);
  }

  set password(String password) {
    box.write("password", password);
  }

  set money(int money) {
    box.write("money", money);
  }

  set phone(String phone) {
    box.write("phone", phone);
  }

  void delete() {
    box.remove("name");
    box.remove("phone");
    box.remove("money");
    box.remove("password");
  }
}
