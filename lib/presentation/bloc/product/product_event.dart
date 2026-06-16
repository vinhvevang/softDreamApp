import '../../../domain/entities/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddProductRequested extends ProductEvent {
  final String name;
  final String quanity;
  final String price;

  AddProductRequested({
    required this.name,
    required this.quanity,
    required this.price,
  });
}

class UpdateProductRequested extends ProductEvent {
  final Product product;
  final String name;
  final String quanity;
  final String price;

  UpdateProductRequested({
    required this.product,
    required this.name,
    required this.quanity,
    required this.price,
  });
}

class DeleteProductRequested extends ProductEvent {
  final String id;
  DeleteProductRequested(this.id);
}

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);
}

class ApplyFilter extends ProductEvent {
  final String name;
  final String price;

  ApplyFilter({
    required this.name,
    required this.price,
  });
}

class ClearFilter extends ProductEvent {}