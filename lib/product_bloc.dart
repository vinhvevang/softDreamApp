import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_fresher_training/model/model.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel product;
  AddProduct(this.product);
}

class UpdateProduct extends ProductEvent {
  final ProductModel product;
  UpdateProduct(this.product);
}

class DeleteProduct extends ProductEvent {
  final String id;
  DeleteProduct(this.id);
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

class ProductState {
  final List<ProductModel> products;
  final String searchQuery;
  final String filterName;
  final String filterPrice;

  const ProductState({
    this.products = const [],
    this.searchQuery = '',
    this.filterName = '',
    this.filterPrice = '',
  });

  ProductState copyWith({
    List<ProductModel>? products,
    String? searchQuery,
    String? filterName,
    String? filterPrice,
  }) {
    return ProductState(
      products: products ?? this.products,
      searchQuery: searchQuery ?? this.searchQuery,
      filterName: filterName ?? this.filterName,
      filterPrice: filterPrice ?? this.filterPrice,
    );
  }

  List<ProductModel> get filteredProducts {
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

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<LoadProducts>((event, emit) {
      emit(
        state.copyWith(
          products: [
            ProductModel(id: '1', name: 'Áo thun', quanity: 10, price: 120000),
            ProductModel(id: '2', name: 'Quần jean', quanity: 5, price: 250000),
            ProductModel(id: '3', name: 'Giày thể thao', quanity: 3, price: 780000),
            ProductModel(id: '4', name: 'Áo sơ mi', quanity: 8, price: 180000),
          ],
        ),
      );
    });

    on<AddProduct>((event, emit) {
      final updated = [event.product, ...state.products];
      emit(state.copyWith(products: updated));
    });

    on<UpdateProduct>((event, emit) {
      final updated = state.products.map((e) {
        return e.id == event.product.id ? event.product : e;
      }).toList();
      emit(state.copyWith(products: updated));
    });

    on<DeleteProduct>((event, emit) {
      final updated = state.products.where((e) => e.id != event.id).toList();
      emit(state.copyWith(products: updated));
    });

    on<SearchProducts>((event, emit) {
      emit(state.copyWith(searchQuery: event.query));
    });

    on<ApplyFilter>((event, emit) {
      emit(
        state.copyWith(
          filterName: event.name,
          filterPrice: event.price,
        ),
      );
    });

    on<ClearFilter>((event, emit) {
      emit(
        state.copyWith(
          filterName: '',
          filterPrice: '',
        ),
      );
    });
  }
}