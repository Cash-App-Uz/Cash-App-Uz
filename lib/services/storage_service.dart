import 'package:get_storage/get_storage.dart';

class MyPref {
  Future<void> init() async {
    await GetStorage.init();
  }

  GetStorage box = GetStorage();
  String get name => box.read("name") ?? '';

  set name(String name) {
    box.write("name", name);
  }

  void delete() {
    box.remove("name");
  }
}
