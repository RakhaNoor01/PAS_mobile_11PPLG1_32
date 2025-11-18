import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widget_button.dart';
import '../routes/routes.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange[700],
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_person_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Login to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: controller.usernameController,
                    hintText: 'Username',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                        obscureText: controller.obscurePassword.value,
                      )),
                  const SizedBox(height: 30),
                  Obx(() => controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : CustomButton(
                          text: 'LOGIN',
                          onPressed: () => controller.login(),
                        )),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: const Text(
                      'Tidak punya akun? Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
