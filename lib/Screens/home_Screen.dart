import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../AppRoutes/app_routes.dart';
import '../Network/product_&_category.dart';
import '../Widgets/products_card.dart';
import '../controller/product_&_category_controler.dart';
import '../controller/product_bloc.dart';
import '../controller/product_event.dart';
import '../controller/product_state.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductCategoryController controller = Get.put(ProductCategoryController());

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  //String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ProductBloc(FetchProduct())..add(FetchProductsEvent()),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body:
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        readOnly: true,
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
                        onTap: (){
                          Get.toNamed(AppRoutes.searchProduct);
                          //Get.to(()=>SearchPage());
                          controller.searchResults.value.clear();
                        },
                      ),
                    ),

                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state.productsInfo.products == null || state.productsInfo.products!.isEmpty) {
                          return const Center(child: Text("No products found"));
                        }
                        return buildGridView(screenWidth,state);
                      },
                    )

                  ],
                )
        ),

      ),
    );

  }

  Expanded buildGridView(double screenWidth, ProductState state) {
    final itemWidth = (screenWidth - 48) / 2; // 16 * 2 padding + 16 spacing
    final itemHeight = itemWidth / 0.68;



    if (state.productsInfo.products == null || state.productsInfo.products!.isEmpty) {
      return Expanded(child: Center(child: Text("No products found")));
    }else{
      return Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount:state.productsInfo.products!.length,
          itemBuilder: (context, index) {
            final product = state.productsInfo.products![index];
            final image = product.images![0];
            return GestureDetector(
              onTap: (){

              },
              child: GridProductCard(
                imageUrl: image,
                title: product.title,
                price: product.price,
                rating: product.rating,
                category: product.category,
                id: product.id,
                stock: product.stock,
                discount: product.discountPercentage,
              ),
            );
          },
        ),
      );
    }


  }

}
