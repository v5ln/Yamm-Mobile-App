// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Merchant {
  final String id;
  final String name;
  final String website;
  final String logo;
  final String verification_method;
  Merchant(
      {required this.id,
      required this.name,
      required this.website,
      required this.logo,
      required this.verification_method});

  Merchant copyWith(
      {String? id,
      String? name,
      String? website,
      String? logo,
      String? verification_method}) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      website: website ?? this.website,
      logo: logo ?? this.logo,
      verification_method: verification_method ?? this.verification_method,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'website': website,
      'logo': logo,
      'verification_method': verification_method
    };
  }

  factory Merchant.fromMap(Map<String, dynamic> map) {
    return Merchant(
        id: map['id'] as String,
        name: map['name'] as String,
        website: map['website'] as String,
        logo: map['logo'] as String,
        verification_method: map['verification_method'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Merchant.fromJson(String source) =>
      Merchant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Store(id: $id, name: $name, website: $website, logo: $logo, verification_method: $verification_method)';
  }

  @override
  bool operator ==(covariant Merchant other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.website == website &&
        other.logo == logo &&
        other.verification_method == verification_method;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        website.hashCode ^
        logo.hashCode ^
        verification_method.hashCode;
  }
}
