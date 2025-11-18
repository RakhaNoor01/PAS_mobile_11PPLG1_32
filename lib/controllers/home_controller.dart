import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Table_Model.dart';
import '../network/client_network.dart';
import '../routes/routes.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var products = <TableModel>[].obs;
  var username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsername();
    fetchProducts();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'User';
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final result = await ClientNetwork.fetchProducts();
      products.value = result;
      print('Loaded ${result.length} products');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToDetail(TableModel product) {
    Get.toNamed(AppRoutes.detail, arguments: product);
  }
}
