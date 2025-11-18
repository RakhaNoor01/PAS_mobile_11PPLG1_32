import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_navigation_controller.dart';
import '../pages/home_page.dart';
import '../pages/favorites_page.dart';
import '../pages/profile_page.dart';

class BottomNavigationPage extends GetView<BottomNavigationController> {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const FavoritesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (index) => controller.changePage(index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.orange[700],
              unselectedItemColor: Colors.grey[400],
              selectedFontSize: 14,
              unselectedFontSize: 12,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded, size: 28),
                  activeIcon: Icon(Icons.home, size: 30),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded, size: 28),
                  activeIcon: Icon(Icons.favorite, size: 30),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded, size: 28),
                  activeIcon: Icon(Icons.person, size: 30),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}