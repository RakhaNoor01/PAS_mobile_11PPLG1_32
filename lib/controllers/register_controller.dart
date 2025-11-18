import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // TAMBAHKAN INI
import '../network/client_network.dart';
import '../routes/routes.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> register() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();

    // Validate all fields
    if (username.isEmpty) {
      Get.snackbar(
        'Error',
        'Username tidak boleh kosong!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (fullName.isEmpty) {
      Get.snackbar(
        'Error',
        'Full Name tidak boleh kosong!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email tidak boleh kosong!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        'Password tidak boleh kosong!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Basic email validation
    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar(
        'Error',
        'Format email tidak valid!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    print('=== Data sebelum dikirim ===');
    print('Username: "$username" (length: ${username.length})');
    print('Password: "$password" (length: ${password.length})');
    print('Full Name: "$fullName" (length: ${fullName.length})');
    print('Email: "$email" (length: ${email.length})');
    print('============================');

    isLoading.value = true;

    try {
      final response = await ClientNetwork.registerUser(username, password, fullName, email);

      print('Register response received: $response');

      if (response['status'] == true) {
        // Simpan email ke SharedPreferences untuk digunakan di profile
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('registered_email', email);
        
        Get.snackbar(
          'Success',
          'Registrasi berhasil! Silakan login.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

        // Clear all fields
        usernameController.clear();
        passwordController.clear();
        fullNameController.clear();
        emailController.clear();

        Get.offNamed(AppRoutes.login);
      } else {
        String errorMsg = response['message'] ?? 'Registrasi gagal';
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
      print('Register error caught: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}