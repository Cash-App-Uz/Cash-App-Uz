
import 'package:cash_app/constants/imports.dart';

class IoModel {
  const IoModel({
    required this.amount,
    required this.category,
    required this.cause,
    required this.icon,
    required this.time,
  });
  final num amount;
  final String category;
  final String cause;
  final String icon;
  final DateTime time;
  factory IoModel.fromJson(Map<String, dynamic> json) => IoModel(
        amount: json["amount"],
        category: json["category"],
        cause: json["cause"],
        icon: json["icon"],
        time: (json["time"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "category": category,
        "cause": cause,
        "icon": icon,
        "time":
            Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch)
      };
}
