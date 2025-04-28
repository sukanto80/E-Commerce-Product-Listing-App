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
  final ScrollController _scrollController = ScrollController();
  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      final bloc = context.read<ProductBloc>();
      if (!bloc.state.isLoadingMore) {
        bloc.add(LoadMoreProductsEvent());
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    //_scrollController.dispose();
    super.dispose();
  }
  //String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
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
                        print('Total displayed after load more: ${state.displayedProducts.length}');
                        if (state.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state.displayedProducts.isEmpty) {
                          return const Center(child: Text("No products found"));
                        }
                        return buildGridView(screenWidth,state);
                      },
                    )

                  ],
                )
        ),

      );


  }

  Expanded buildGridView(double screenWidth, ProductState state) {
    final itemWidth = (screenWidth - 48) / 2; // 16 * 2 padding + 16 spacing
    final itemHeight = itemWidth / 0.68;

    if (state.displayedProducts == null || state.displayedProducts!.isEmpty) {
      return Expanded(child: Center(child: Text("No products found")));
    }else{
      return Expanded(
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount: state.displayedProducts.length + (state.isLoadingMore ? 1 : 0),

          itemBuilder: (context, index) {
            print("Product item count>>>>>>>>>:${state.displayedProducts.length}");
            if (index < state.displayedProducts.length) {
              final product = state.displayedProducts[index];
              return GridProductCard(
                imageUrl: product.images![0],
                title: product.title,
                price: product.price,
                rating: product.rating,
                category: product.category,
                id: product.id,
                stock: product.stock,
                discount: product.discountPercentage,
              );
            } else {
              return const Center(child: CircularProgressIndicator()); // 👈 loader
            }
          },
        ),
      );
    }


  }

}
