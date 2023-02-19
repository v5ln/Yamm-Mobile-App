class Reason {
  final int id;
  final String name;
  Reason({
    required this.id,
    required this.name,
  });

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["id"],
        name: json["name"],
      );
}
