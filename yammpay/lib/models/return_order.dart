// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReturnOrder {
  final String order_number;
  final String store_id;
  final int agreement_id;
  final int bank_id;
  final List<ItemId> items;
  ReturnOrder({
    required this.order_number,
    required this.store_id,
    required this.agreement_id,
    required this.bank_id,
    required this.items,
  });

  ReturnOrder copyWith({
    String? order_number,
    String? store_id,
    int? agreement_id,
    int? bank_id,
    List<ItemId>? items,
  }) {
    return ReturnOrder(
      order_number: order_number ?? this.order_number,
      store_id: store_id ?? this.store_id,
      agreement_id: agreement_id ?? this.agreement_id,
      bank_id: bank_id ?? this.bank_id,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_number': order_number,
      'store_id': store_id,
      'agreement_id': agreement_id,
      'bank_id': bank_id,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ReturnOrder.fromMap(Map<String, dynamic> map) {
    return ReturnOrder(
      order_number: map['order_number'] as String,
      store_id: map['store_id'] as String,
      agreement_id: map['agreement_id'] as int,
      bank_id: map['bank_id'] as int,
      items: List<ItemId>.from(
        (map['items'] as List<int>).map<ItemId>(
          (x) => ItemId.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReturnOrder.fromJson(String source) =>
      ReturnOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReturnOrder(order_number: $order_number, store_id: $store_id, agreement_id: $agreement_id, bank_id: $bank_id, items: $items)';
  }

  @override
  bool operator ==(covariant ReturnOrder other) {
    if (identical(this, other)) return true;

    return other.order_number == order_number &&
        other.store_id == store_id &&
        other.agreement_id == agreement_id &&
        other.bank_id == bank_id &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return order_number.hashCode ^
        store_id.hashCode ^
        agreement_id.hashCode ^
        bank_id.hashCode ^
        items.hashCode;
  }
}

class ItemId {
  final int? product_id;
  final int quantity;
  final int reason_id;
  ItemId({
    required this.product_id,
    required this.quantity,
    required this.reason_id,
  });

  ItemId copyWith({
    required int product_id,
    required int quantity,
    required int reason_id,
  }) {
    return ItemId(
        product_id: product_id, quantity: quantity, reason_id: reason_id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'quantity': quantity,
      'reason_id': reason_id,
    };
  }

  factory ItemId.fromMap(Map<String, dynamic> map) {
    return ItemId(
      product_id: map['product_id'] as int,
      quantity: map['quantity'] as int,
      reason_id: map['reason_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemId.fromJson(String source) =>
      ItemId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemId(product_id: $product_id, quantity: $quantity, reason_id: $reason_id)';

  @override
  bool operator ==(covariant ItemId other) {
    if (identical(this, other)) return true;

    return other.product_id == product_id &&
        other.quantity == quantity &&
        other.reason_id == reason_id;
  }

  @override
  int get hashCode =>
      product_id.hashCode ^ quantity.hashCode ^ reason_id.hashCode;
}
