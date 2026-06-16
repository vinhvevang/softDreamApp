import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _products = [
    const Product(id: '1', name: 'Áo thun', quanity: 10, price: 120000),
    const Product(id: '2', name: 'Quần jean', quanity: 5, price: 250000),
    const Product(id: '3', name: 'Giày thể thao', quanity: 3, price: 780000),
    const Product(id: '4', name: 'Áo sơ mi', quanity: 8, price: 180000),
  ];

  @override
  List<Product> getAllProducts() => List.unmodifiable(_products);

  @override
  void addProduct(Product product) {
    _products.insert(0, product);
  }

  @override
  void updateProduct(Product product) {
    final index = _products.indexWhere((e) => e.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  @override
  void deleteProduct(String id) {
    _products.removeWhere((e) => e.id == id);
  }
}