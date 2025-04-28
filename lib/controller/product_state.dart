
import '../Model_Class/products_info.dart';

class ProductState {
  final ProductsInfo productsInfo;
  final List<Product> displayedProducts;
  final bool isLoadingMore; // ✅ Add this field
  final List<Product> searchResults;
  final bool isLoading;
  final int currentPage;  // Track the current page

   ProductState({
    ProductsInfo? productsInfo,
    this.displayedProducts = const [],
    List<Product>? searchResults,
    this.isLoading = false,
    this.isLoadingMore = false,// Default false
     this.currentPage = 0,  // Default page is 0
  }):productsInfo = productsInfo ?? ProductsInfo(products: []),
        searchResults = searchResults ?? const [];

  ProductState copyWith({
    ProductsInfo? productsInfo,
    List<Product>? searchResults,
    List<Product>? displayedProducts,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
  }) {
    return ProductState(
      productsInfo: productsInfo ?? this.productsInfo,
      displayedProducts: displayedProducts ?? this.displayedProducts,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    productsInfo,
    searchResults,
    displayedProducts,
    isLoading,
    isLoadingMore,
    currentPage
  ];
}
