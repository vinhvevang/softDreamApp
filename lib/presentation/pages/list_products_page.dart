import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({super.key});

  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  final TextEditingController findProducts = TextEditingController();

  @override
  void dispose() {
    findProducts.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    final nameController = TextEditingController();
    final quanityController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Thêm sản phẩm"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Tên sản phẩm",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: quanityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "Số lượng",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "Giá tiền",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(
                      AddProductRequested(
                        name: nameController.text,
                        quanity: quanityController.text,
                        price: priceController.text,
                      ),
                    );

                Navigator.pop(dialogContext);
              },
              child: const Text("Thêm"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Product product) {
    final nameController = TextEditingController(text: product.name);
    final quanityController =
        TextEditingController(text: product.quanity.toString());
    final priceController =
        TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Sửa sản phẩm"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Tên sản phẩm",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: quanityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "Số lượng",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "Giá tiền",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(
                      UpdateProductRequested(
                        product: product,
                        name: nameController.text,
                        quanity: quanityController.text,
                        price: priceController.text,
                      ),
                    );

                Navigator.pop(dialogContext);
              },
              child: const Text("Lưu"),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Lọc sản phẩm"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Lọc theo tên",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "Lọc theo giá",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ProductBloc>().add(ClearFilter());
                Navigator.pop(dialogContext);
              },
              child: const Text("Xóa lọc"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(
                      ApplyFilter(
                        name: nameController.text,
                        price: priceController.text,
                      ),
                    );
                Navigator.pop(dialogContext);
              },
              child: const Text("Áp dụng"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: findProducts,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      context.read<ProductBloc>().add(SearchProducts(value));
                    },
                    onFieldSubmitted: (value) {
                      context.read<ProductBloc>().add(SearchProducts(value));
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepOrange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text("Nhập tên / số lượng / giá cần tìm"),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<ProductBloc>().add(
                                SearchProducts(findProducts.text),
                              );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _showFilterDialog,
                icon: const Icon(Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final products = state.filteredProducts;

                if (products.isEmpty) {
                  return const Center(
                    child: Text("Không có sản phẩm nào"),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text("Số lượng: ${product.quanity}"),
                            const SizedBox(height: 6),
                            Text("Giá: ${product.price} đ"),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => _showEditDialog(product),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<ProductBloc>().add(
                                          DeleteProductRequested(product.id),
                                        );
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF24E1E),
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}