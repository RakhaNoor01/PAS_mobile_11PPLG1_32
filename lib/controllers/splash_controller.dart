import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('✅ SplashController onInit called!');
  }

  @override
  void onReady() {
    super.onReady();
    print('✅ SplashController onReady called!');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    try {
      print('⏳ Waiting 2 seconds...');
      await Future.delayed(const Duration(seconds: 2));

      print('🔍 Checking SharedPreferences...');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print('📊 Token: ${token != null ? 'Present' : 'Null'}');

      if (token != null && token.isNotEmpty) {
        print('🏠 Going to BottomNavigation...');
        Get.offAllNamed(AppRoutes.bottomNavigation);
      } else {
        print('🔐 Going to Register...');
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      print('❌ Error: $e');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
