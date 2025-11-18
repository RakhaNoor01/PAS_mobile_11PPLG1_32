import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/routes.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var profileImageUrl = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      
      username.value = prefs.getString('username') ?? 'User';
      email.value = prefs.getString('email') ?? 'user@example.com';
      
      profileImageUrl.value = 'https://i.pinimg.com/736x/eb/72/50/eb72505d35a4a2b2ef36ece9dd857e9c.jpg'; //foto profil, Spe-chan so funny
      
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      buttonColor: Colors.orange[700],
      cancelTextColor: Colors.orange[700],
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.back();
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar(
          'Success',
          'Logged out successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
