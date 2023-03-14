class Image {
  final String? id;
  final int? productId;
  final int? position;
  final dynamic? alt;
  final int? width;
  final int? height;
  final String url;
  Image({
    required this.id,
    required this.productId,
    required this.position,
    required this.alt,
    required this.width,
    required this.height,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        position: json["position"],
        alt: json["alt"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "position": position,
        "alt": alt,
        "width": width,
        "height": height,
        "url": url,
      };
}
