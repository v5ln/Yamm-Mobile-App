import 'package:yammpay/models/item.dart';

class Order {
  int orderId;
  int orderNumber;
  List<Item> items;
  double? subtotalPrice;
  double? totalDiscountsPrice;
  int? totalTax;
  double? totalPrice;
  String currency;
  dynamic? cancelReason;
  dynamic? cancelledAt;
  Order({
    required this.orderId,
    required this.orderNumber,
    required this.items,
    this.subtotalPrice,
    this.totalDiscountsPrice,
    this.totalTax,
    this.totalPrice,
    required this.currency,
    this.cancelReason,
    this.cancelledAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        orderNumber: json["order_number"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        subtotalPrice: json["subtotal_price"],
        totalDiscountsPrice: json["total_discounts_price"],
        totalTax: json["total_tax"],
        totalPrice: json["total_price"],
        currency: json["currency"],
        cancelReason: json["cancel_reason"],
        cancelledAt: json["cancelled_at"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_number": orderNumber,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "subtotal_price": subtotalPrice,
        "total_discounts_price": totalDiscountsPrice,
        "total_tax": totalTax,
        "total_price": totalPrice,
        "currency": currency,
        "cancel_reason": cancelReason,
        "cancelled_at": cancelledAt,
      };
}
