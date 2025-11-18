import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Madura App',
      debugShowCheckedModeBanner: false, //matiin bener debug dipojok kanan (menganggu)
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}