import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Table_Model.dart';
import '../helper/db_helper.dart';
import 'favorites_controller.dart';

class DetailController extends GetxController {
  late TableModel product;
  var isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as TableModel;
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    isFavorite.value = await DatabaseHelper.instance.isFavorite(product.id);
  }

  Future<void> toggleFavorite() async {
    if (isFavorite.value) {
      await DatabaseHelper.instance.deleteFavoriteByCharacterId(product.id);
      Get.snackbar(
        'Removed',
        '${product.title} removed from favorites',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      await DatabaseHelper.instance.insertFavorite({
        'characterId': product.id,
        'nameEn': product.title,
        'nameJp': product.category.toString().split('.').last,
        'thumbImg': product.image,
        'colorMain': '#FF6B35',
      });
      Get.snackbar(
        'Added',
        '${product.title} added to favorites',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isFavorite.value = !isFavorite.value;

    if (Get.isRegistered<FavoritesController>()) {
      Get.find<FavoritesController>().loadFavorites();
    }
  }
}
