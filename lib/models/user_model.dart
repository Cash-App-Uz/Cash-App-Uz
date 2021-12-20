class UserModer {
  UserModer({
    required this.name,
    required this.password,
    required this.phone,
    required this.money,
  });

  String name;
  String password;
  String phone;
  int money;

  factory UserModer.fromJson(Map<String, dynamic> json) => UserModer(
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
