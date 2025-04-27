import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AppRoutes/app_routes.dart';
import '../Widgets/products_card.dart';
import '../controller/product_&_category_controler.dart';

class SearchPage extends StatelessWidget {
  final ProductCategoryController searchController = Get.put(ProductCategoryController());

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by product name...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                searchController.searchProducts(value);
              },
            ),
          ),

          // Results
          Expanded(
            child: Obx(() {
              if (searchController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (searchController.searchResults.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: searchController.searchResults.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = searchController.searchResults[index];
                  return GestureDetector(
                    onTap: () {

                    },
                    child: GridProductCard(
                      imageUrl: product.thumbnail,
                      title: product.title,
                      price: product.price?.toDouble(),
                      rating: product.rating?.toDouble(),
                      category: product.category,
                      id: product.id,
                      stock: product.stock,
                      discount: product.discountPercentage,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
