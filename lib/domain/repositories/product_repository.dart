import '../entities/product.dart';

abstract class ProductRepository {
  List<Product> getAllProducts();
  void addProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(String id);
}