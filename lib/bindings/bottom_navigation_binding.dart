import 'package:get/get.dart';
import '../controllers/bottom_navigation_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/profile_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FavoritesController>(() => FavoritesController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}