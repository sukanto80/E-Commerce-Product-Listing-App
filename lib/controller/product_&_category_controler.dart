import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Model_Class/products_info.dart';
import '../Network/product_&_category.dart';

class ProductCategoryController extends GetxController {
  var productsInfo = ProductsInfo(products: []).obs;
  var searchResults = <Product>[].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;
  @override
  void onInit() async {
    print("call onInit");

    fetchProducts();

    super.onInit();
  }


  fetchProducts() async {
    isLoading.value = true; // Start loading

    try {
      final fetcher = FetchProduct();
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




  void searchProducts(String query) async {
    searchResults.value.clear();
    update();
    isLoading(true);
    final fetcher = FetchProduct();
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

