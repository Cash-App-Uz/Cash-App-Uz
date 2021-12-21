class UserModel {
  UserModel({
    required this.name,
    required this.password,
    required this.phone,
    required this.money,
  });

  String name;
  String password;
  String phone;
  int money;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        password: json["password"],
        phone: json["phone"],
        money: json["money"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "phone": phone,
        "money": money,
      };
}
