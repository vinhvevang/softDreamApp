class Product {
  final String id;
  final String name;
  final int quanity;
  final int price;

  const Product({
    required this.id,
    required this.name,
    required this.quanity,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? name,
    int? quanity,
    int? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quanity: quanity ?? this.quanity,
      price: price ?? this.price,
    );
  }
}