import '../../../domain/entities/product.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  final ProductStatus status;
  final List<Product> products;
  final String searchQuery;
  final String filterName;
  final String filterPrice;
  final String? message;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.searchQuery = '',
    this.filterName = '',
    this.filterPrice = '',
    this.message,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? searchQuery,
    String? filterName,
    String? filterPrice,
    String? message,
    bool clearMessage = false,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      searchQuery: searchQuery ?? this.searchQuery,
      filterName: filterName ?? this.filterName,
      filterPrice: filterPrice ?? this.filterPrice,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  List<Product> get filteredProducts {
    final q = searchQuery.trim().toLowerCase();
    final fName = filterName.trim().toLowerCase();
    final fPrice = filterPrice.trim().toLowerCase();

    return products.where((p) {
      final name = p.name.toLowerCase();
      final quanity = p.quanity.toString();
      final price = p.price.toString();

      final matchesSearch = q.isEmpty ||
          name.contains(q) ||
          quanity.contains(q) ||
          price.contains(q);

      final matchesName = fName.isEmpty || name.contains(fName);
      final matchesPrice = fPrice.isEmpty || price.contains(fPrice);

      return matchesSearch && matchesName && matchesPrice;
    }).toList();
  }
}