
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../Model_Class/products_info.dart';
 import 'package:http/http.dart' as http;

class FetchProductCategory{

  Future<ProductsInfo> fetchPostData() async {
    final url = Uri.parse('https://dummyjson.com/products?limit=100');
    try {
      final response = await http.get(url).timeout(Duration(seconds:2));

      if (response.statusCode == 200) {
        return productsInfoFromJson(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } on http.ClientException {
      if (kDebugMode) {
        print("Network Error");
      }
    } on TimeoutException {
      if (kDebugMode) {
        print("Request Timed Out");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected Error: $e");
      }
    }

    // ✅ Return an empty ProductsInfo object instead of a List
    return ProductsInfo(products: [], total: 0, skip: 0, limit: 0);
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final url = Uri.parse('https://dummyjson.com/products/categories');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<ProductsInfo> fetchProductsByCategory(String category) async {
    final url = Uri.parse('https://dummyjson.com/products/category/$category');
    try {
      final response = await http.get(url).timeout(Duration(seconds:2));

      if (response.statusCode == 200) {
        return productsInfoFromJson(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } on http.ClientException {
      if (kDebugMode) {
        print("Network Error");
      }
    } on TimeoutException {
      if (kDebugMode) {
        print("Request Timed Out");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected Error: $e");
      }
    }

    // ✅ Return an empty ProductsInfo object instead of a List
    return ProductsInfo(products: [], total: 0, skip: 0, limit: 0);

  }

  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('https://dummyjson.com/products/search?q=$query');
    final response = await http.get(url);
 try{
   if (response.statusCode == 200) {
     final jsonData = json.decode(response.body);
     final List productsJson = jsonData['products'];

     return productsJson.map((e) => Product.fromJson(e)).toList();
   } else {
     throw Exception('Failed to load searched products');
   }
 }catch(e){
   throw Exception('Failed to load searched products$e');
 }
  }




}