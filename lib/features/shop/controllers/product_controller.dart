import 'package:get/get.dart';
import 'package:water_boy/data/repository/shop/product_repository.dart';
import 'package:water_boy/features/shop/models/product_model.dart';

import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance=>Get.find();
  final productRepo = Get.put(ProductRepository());

  RxList<ProductModel> featuredProduct = <ProductModel>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;

      // Fetch products
      final products = await productRepo.fetchProducts();
      print('product ======> $products');

      featuredProduct.assignAll(products);

    } catch(e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {

    }
  }
}
