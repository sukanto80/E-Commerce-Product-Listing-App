import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Model_Class/products_info.dart';
import '../Network/product_&_category.dart';

class ProductCategoryController extends GetxController {
  var productsInfo = ProductsInfo(products: []).obs;
  var categoryProducts = ProductsInfo(products: []).obs;
  var searchResults = <Product>[].obs;
  var categories = [].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;
  @override
  void onInit() async {
    print("call onInit");
    loadCategories();
    fetchProducts();

    super.onInit();
  }


  fetchProducts() async {
    isLoading.value = true; // Start loading

    try {
      final fetcher = FetchProductCategory();
      ProductsInfo response = await fetcher.fetchPostData();
      productsInfo.value = response;
      update();
      if (kDebugMode) {
        print(' fetching products: ${productsInfo.value}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      isLoading.value = false; // Done loading
      update();
    }
  }
  Future<void> loadProductsByCategory(String category) async {
    try {
      final fetcher = FetchProductCategory();
      isLoading(true);
      selectedCategory.value = category;
      categoryProducts.value = await fetcher.fetchProductsByCategory(category);
      update();
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadCategories() async {
    try {
      final fetcher = FetchProductCategory();
      isLoading(true);
      categories.value = await fetcher.fetchCategories();
      update();
    } finally {
      isLoading(false);
    }
  }

  void searchProducts(String query) async {
    searchResults.value.clear();
    update();
    isLoading(true);
    final fetcher = FetchProductCategory();
    try {
      searchResults.value = await fetcher.searchProducts(query);
      update();
    } catch (e) {
      print("Search error: $e");
    } finally {
      isLoading(false);
      update();
    }
  }



  }

