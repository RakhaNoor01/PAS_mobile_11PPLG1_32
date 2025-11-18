import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widget_button.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange[700], // Ubah ke kuning solid
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_add_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Register to get started',
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
                  CustomTextField(
                    controller: controller.fullNameController,
                    hintText: 'Full Name',
                    icon: Icons.account_circle,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    icon: Icons.email,
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
                          text: 'REGISTER',
                          onPressed: () => controller.register(),
                        )),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
