import 'package:e_comers/app/data/models/CategoriesProduct.dart';
import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/color.dart';

class HomeController extends GetxController {
  final _api = Get.find<APIProvider>();
  Rx<CategoriesProduct> product = Rx(CategoriesProduct());

  var favoriteCount = 1.obs;
  var dotIndex = 0.obs;

  Future<void> getProduct() async {
    try {
      final response = await _api.getProduct();
      if (response.statusCode == 200) {
        product(CategoriesProduct.fromJson(response.data));
        return;
      }
      throw response.data['message'] ?? "";
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addToCard({required int id, required int quantity}) async {
    try {
      final response = await _api.addCard(id: id, quantity: quantity);
      print("Status code ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar(
          "Successes",
          "Product added to Card",
          backgroundColor: AppColors.cyanTeal,
          colorText: Colors.white,
        );
        return;
      }
    } catch (e) {
      print("Error From Cart : ${e.toString()}");
    }
  }

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }
}
