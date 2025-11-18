import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/db_helper.dart';

class FavoritesController extends GetxController {
  var favorites = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      isLoading.value = true;
      final result = await DatabaseHelper.instance.getAllFavorites();
      favorites.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load favorites: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFavorite(int id, String name) async {
    await DatabaseHelper.instance.deleteFavorite(id);
    Get.snackbar(
      'Deleted',
      '$name removed from favorites',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    loadFavorites();
  }

  Future<void> deleteAllFavorites() async {
    Get.defaultDialog(
      title: 'Delete All',
      middleText: 'Are you sure you want to delete all favorites?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await DatabaseHelper.instance.deleteAllFavorites();
        Get.back();
        Get.snackbar(
          'Cleared',
          'All favorites have been deleted',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        loadFavorites();
      },
    );
  }
}