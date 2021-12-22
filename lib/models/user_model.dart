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
  num money;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        password: json["password"],
        phone: json["phone"],
        money: num.parse(json["money"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "phone": phone,
        "money": money,
      };
}
