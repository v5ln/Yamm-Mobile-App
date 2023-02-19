// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankList {
  final int id;
  late final String name;
  final String logo;
  final double min_refund_amount;
  final double max_refund_amount;

  BankList(this.id, this.name, this.logo, this.min_refund_amount,
      this.max_refund_amount);

  BankList copyWith({
    int? id,
    String? name,
    String? logo,
    double? min_refund_amount,
    double? max_refund_amount,
  }) {
    return BankList(
      id ?? this.id,
      name ?? this.name,
      logo ?? this.logo,
      min_refund_amount ?? this.min_refund_amount,
      max_refund_amount ?? this.max_refund_amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'min_refund_amount': min_refund_amount,
      'max_refund_amount': max_refund_amount,
    };
  }

  factory BankList.fromMap(Map<String, dynamic> map) {
    return BankList(
      map['id'] as int,
      map['name'] as String,
      map['logo'] as String,
      map['min_refund_amount'] as double,
      map['max_refund_amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankList.fromJson(String source) =>
      BankList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankList(id: $id, name: $name, logo: $logo, min_refund_amount: $min_refund_amount, max_refund_amount: $max_refund_amount)';
  }

  @override
  bool operator ==(covariant BankList other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.logo == logo &&
        other.min_refund_amount == min_refund_amount &&
        other.max_refund_amount == max_refund_amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        min_refund_amount.hashCode ^
        max_refund_amount.hashCode;
  }
}
