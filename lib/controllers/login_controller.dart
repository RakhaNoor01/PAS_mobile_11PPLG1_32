import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../network/client_network.dart';
import '../routes/routes.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Username dan Password tidak boleh kosong!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await ClientNetwork.loginUser(username, password);

      print('Login response received: $response');

      // Check if login successful
      if (response['status'] == true) {
        String token = response['token'] ?? 'api_token_${DateTime.now().millisecondsSinceEpoch}';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('username', username);
        
        // Ambil email yang tersimpan saat register
        String? savedEmail = prefs.getString('registered_email');
        if (savedEmail != null && savedEmail.isNotEmpty) {
          await prefs.setString('email', savedEmail);
        } else {
          // Jika tidak ada email tersimpan, gunakan default
          await prefs.setString('email', '$username@gmail.com');
        }

        Get.snackbar(
          'Success',
          'Login berhasil! Selamat datang $username',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        Get.offAllNamed(AppRoutes.bottomNavigation);
      } else {
        // Show specific error message from API
        String errorMsg = response['message'] ?? 'Login gagal';
        Get.snackbar(
          'Error',
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      print('Login error caught: $e');
      
      // Fallback to static validation if API fails
      if (LoginModel.validate(username, password)) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', 'fallback_token');
        await prefs.setString('username', username);
        
        // Ambil email yang tersimpan saat register
        String? savedEmail = prefs.getString('registered_email');
        if (savedEmail != null && savedEmail.isNotEmpty) {
          await prefs.setString('email', savedEmail);
        } else {
          // Jika tidak ada email tersimpan, gunakan default
          await prefs.setString('email', '$username@gmail.com');
        }

        Get.snackbar(
          'Success',
          'Login berhasil (fallback)! Selamat datang $username',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        Get.offAllNamed(AppRoutes.bottomNavigation);
      } else {
        Get.snackbar(
          'Error',
          'Login gagal. Periksa username dan password Anda.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
      }
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
