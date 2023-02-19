// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:yammpay/models/Image.dart';

// ID TITLE PRICE VARIANT TITLE IMAGE

class Item {
  final String id;
  final bool? gift;
  final String? name;
  final String title;
  final int price;
  final String? productId;
  final int? quantity;
  final int? totalDiscount;
  final int? variantId;
  final String? variantTitle;
  final String? vendor;
  final Image image;
  final List<Image>? images;
  final bool? isRefundable;
  Item({
    required this.id,
    this.gift,
    this.name,
    this.isRefundable = true,
    required this.title,
    required this.price,
    this.productId,
    this.quantity,
    this.totalDiscount,
    this.variantId,
    required this.variantTitle,
    this.vendor,
    required this.image,
    this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        gift: json["gift"],
        name: json["name"],
        title: json["title"],
        price: json["price"],
        productId: json["product_id"],
        quantity: json["quantity"],
        totalDiscount: json["total_discount"],
        variantId: json["variant_id"],
        variantTitle: json["variant_title"],
        vendor: json["vendor"],
        image: Image.fromJson(json["image"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gift": gift,
        "name": name,
        "title": title,
        "price": price,
        "product_id": productId,
        "quantity": quantity,
        "total_discount": totalDiscount,
        "variant_id": variantId,
        "variant_title": variantTitle,
        "vendor": vendor,
        "image": image.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}
