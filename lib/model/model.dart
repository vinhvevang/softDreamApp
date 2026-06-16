class ProductModel {
  final String id;
  final String name;
  final int quanity;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.quanity,
    required this.price,
  });

  ProductModel copyWith({// use it to change nor all atribute and avoid exception null
    String? id,
    String? name,
    int? quanity,
    int? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quanity: quanity ?? this.quanity,
      price: price ?? this.price,
    );
  }
}