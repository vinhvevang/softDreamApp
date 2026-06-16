import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const ProductState()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProductRequested>(_onAddProduct);
    on<UpdateProductRequested>(_onUpdateProduct);
    on<DeleteProductRequested>(_onDeleteProduct);
    on<SearchProducts>(_onSearchProducts);
    on<ApplyFilter>(_onApplyFilter);
    on<ClearFilter>(_onClearFilter);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      status: ProductStatus.success,
      products: repository.getAllProducts(),
      clearMessage: true,
    ));
  }

  void _onAddProduct(AddProductRequested event, Emitter<ProductState> emit) {
    final name = event.name.trim();
    final quanity = int.tryParse(event.quanity.trim());
    final price = int.tryParse(event.price.trim());

    if (name.isEmpty || quanity == null || price == null) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        message: 'Vui lòng nhập đủ tên, số lượng và giá.',
      ));
      return;
    }

    final product = Product(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      quanity: quanity,
      price: price,
    );

    repository.addProduct(product);

    emit(state.copyWith(
      status: ProductStatus.success,
      products: repository.getAllProducts(),
      clearMessage: true,
    ));
  }

  void _onUpdateProduct(
      UpdateProductRequested event, Emitter<ProductState> emit) {
    final name = event.name.trim();
    final quanity = int.tryParse(event.quanity.trim());
    final price = int.tryParse(event.price.trim());

    if (name.isEmpty || quanity == null || price == null) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        message: 'Vui lòng nhập đủ tên, số lượng và giá.',
      ));
      return;
    }

    final updated = event.product.copyWith(
      name: name,
      quanity: quanity,
      price: price,
    );

    repository.updateProduct(updated);

    emit(state.copyWith(
      status: ProductStatus.success,
      products: repository.getAllProducts(),
      clearMessage: true,
    ));
  }

  void _onDeleteProduct(DeleteProductRequested event, Emitter<ProductState> emit) {
    repository.deleteProduct(event.id);

    emit(state.copyWith(
      status: ProductStatus.success,
      products: repository.getAllProducts(),
      clearMessage: true,
    ));
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      searchQuery: event.query,
      clearMessage: true,
    ));
  }

  void _onApplyFilter(ApplyFilter event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      filterName: event.name,
      filterPrice: event.price,
      clearMessage: true,
    ));
  }

  void _onClearFilter(ClearFilter event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      filterName: '',
      filterPrice: '',
      clearMessage: true,
    ));
  }
}