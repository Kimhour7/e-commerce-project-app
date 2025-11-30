import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:e_comers/app/routes/app_pages.dart';
import 'package:e_comers/app/service/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _api = Get.find<APIProvider>();
  var userName = "".obs;
  var imageUrl = "".obs;
  var isLoading = true.obs; // Optional: track loading state

  void logout() async {
    try {
      final token = await StorageService.read(key: 'token');
      if (token == null) return;
      await _api.logout(token: token);
      StorageService.delete(key: 'token');
      StorageService.delete(key: 'avatar');
      StorageService.delete(key: 'user_id');
      StorageService.delete(key: 'user_name');
      Get.offAndToNamed(Routes.LOGIN);
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text(e.toString()));
    }
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    final avatar = await StorageService.read(key: 'avatar');
    final name = await StorageService.read(key: 'user_name');

    if (avatar != null) imageUrl.value = avatar;
    if (name != null) userName.value = name;
    isLoading.value = false;
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  @override
  void onClose() {
    imageUrl.value = "";
    userName.value = "";
    super.onClose();
  }
}
