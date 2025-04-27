
import 'package:ecommerce_product_listing_app/controller/product_event.dart';
import 'package:ecommerce_product_listing_app/controller/product_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Network/product_&_category.dart';



class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProduct fetcher;

  ProductBloc(this.fetcher) : super(ProductState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await fetcher.fetchPostData();
      emit(state.copyWith(productsInfo: response));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, searchResults: []));
    try {
      final results = await fetcher.searchProducts(event.query);
      emit(state.copyWith(searchResults: results));
    } catch (e) {
      if (kDebugMode) {
        print('Search error: $e');
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
