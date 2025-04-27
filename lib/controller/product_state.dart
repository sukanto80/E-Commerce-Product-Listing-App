
import '../Model_Class/products_info.dart';

class ProductState {
  final ProductsInfo productsInfo;
  final List<Product> searchResults;
  final bool isLoading;

   ProductState({
    ProductsInfo? productsInfo,
    List<Product>? searchResults,
    this.isLoading = false,
  }):productsInfo = productsInfo ?? ProductsInfo(products: []),
        searchResults = searchResults ?? const [];

  ProductState copyWith({
    ProductsInfo? productsInfo,
    List<Product>? searchResults,
    bool? isLoading,
  }) {
    return ProductState(
      productsInfo: productsInfo ?? this.productsInfo,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    productsInfo,
    searchResults,
    isLoading,
  ];
}
