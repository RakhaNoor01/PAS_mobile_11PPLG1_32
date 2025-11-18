import 'package:get/get.dart';
import 'routes.dart';

// Import Pages
import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/bottom_navigation_page.dart';
import '../pages/detail_page.dart';

// Import Bindings
import '../bindings/splash_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/register_binding.dart';
import '../bindings/bottom_navigation_binding.dart';
import '../bindings/detail_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomNavigation,
      page: () => const BottomNavigationPage(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
      binding: DetailBinding(),
    ),
  ];
}
