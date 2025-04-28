import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'AppRoutes/app_routes.dart';
import 'Network/product_&_category.dart';
import 'Screens/home_Screen.dart';
import 'controller/product_bloc.dart';
import 'controller/product_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ProductBloc(FetchProduct())..add(FetchProductsEvent()),
        child: HomeScreen(),
      ),
    );
  }
}

