
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
    on<LoadMoreProductsEvent>(_onLoadMoreProducts); // ✅
  }

  Future<void> _onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await fetcher.fetchPostData();
      emit(state.copyWith(
        productsInfo: response,
        displayedProducts: response.products!.take(10).toList(), // load first 10
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLoadMoreProducts(LoadMoreProductsEvent event, Emitter<ProductState> emit) async {
    final currentState = state;
    final currentPage = currentState.currentPage;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      // Increment page number to fetch next batch of products
      final nextPage = currentPage + 1;

      // Append new products
      final nextProducts = await fetcher.loadFetchProduct(nextPage);

      print('Next product>>>>>>>>>>>>>>>:${nextProducts.length}');
      if (nextProducts.isNotEmpty) {
        emit(state.copyWith(
          displayedProducts: [...currentState.displayedProducts, ...nextProducts], // Append new products
          currentPage: nextPage,
        ));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading more products: $e");
      }
    } finally {
      print('Current displayed: ${currentState.displayedProducts[0].title}');


      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  /*Future<void> _onLoadMoreProducts(LoadMoreProductsEvent event, Emitter<ProductState> emit) async {
    final currentState = state;
    final allProducts = currentState.productsInfo?.products ?? [];
    final currentDisplayed = currentState.displayedProducts.length;
    emit(currentState.copyWith(isLoadingMore: true));
    final nextProducts = allProducts.skip(currentDisplayed).take(10).toList();

    if (nextProducts.isNotEmpty) {
      emit(currentState.copyWith(
        displayedProducts: [...currentState.displayedProducts, ...nextProducts],
      ));
    }
  }*/



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
