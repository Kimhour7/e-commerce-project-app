import 'package:e_comers/app/data/models/searchProduct.dart';
import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  var searchText = "".obs;
  final _api = Get.find<APIProvider>();
  RxList<SearchProduct> product = RxList([]);

  Future<void> searchProduct({required String keyword}) async {
    try {
      final response = await _api.searchProduct(keyword: keyword);
      if (response.statusCode == 200) {
        final data = response.data as List;
        product.value = data.map((e) => SearchProduct.fromJson(e)).toList();
        return;
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    searchFocusNode.requestFocus();
    searchTextController.text = "";
    searchText.value = "";
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    searchTextController.dispose();
    super.onClose();
  }
}
