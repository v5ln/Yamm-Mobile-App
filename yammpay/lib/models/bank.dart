// To parse this JSON data, do
//
//     final bank = bankFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Bank bankFromJson(String str) => Bank.fromJson(json.decode(str));

String bankToJson(Bank data) => json.encode(data.toJson());

class Bank {
  Bank({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.iban,
    required this.customerId,
    required this.bankId,
  });

  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String iban;
  final int customerId;
  final int bankId;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        iban: json["iban"],
        customerId: json["customer_id"],
        bankId: json["bank_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "iban": iban,
        "customer_id": customerId,
        "bank_id": bankId,
      };
}
