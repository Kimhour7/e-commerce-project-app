import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:e_comers/app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final _api = Get.find<APIProvider>();
  var isObscureText = true.obs;
  var isLoading = false.obs;

  var isLoginClicked = true.obs;
  var isSignupClicked = false.obs;

  var emailText = "".obs;
  var passwordText = "".obs;

  void toggleObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  Future<void> loading() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    Get.offAndToNamed(Routes.USER_SCREEN);
    isLoading.value = false;
  }

  void login({required String email, required String password}) async {
    if (emailText.isEmpty || passwordText.isEmpty) {
      Get.defaultDialog(
        title: "Error",
        content: Text("The email and password field is required."),
        actions: [TextButton(onPressed: () => Get.back(), child: Text("okay"))],
      );
      return;
    }
    try {
      isLoading(true);
      final response = await _api.login(email: email, password: password);
      if (response.statusCode == 200) {
        //Save Token To Local Storage
        await StorageService.write(key: 'token', value: response.data['token']);
        await StorageService.write(
          key: 'avatar',
          value: response.data['user']['avatar'] ?? "",
        );
        await StorageService.write(
          key: 'user_name',
          value: response.data['user']['name'],
        );
        await StorageService.write(
          key: 'user_id',
          value: response.data['user']['id'].toString(),
        );
        Get.offAndToNamed(Routes.USER_SCREEN);
        return;
      } else if (response.statusCode == 422) {
        Get.defaultDialog(
          title: "Error",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              response.data["errors"]["email"] != null
                  ? Text("${response.data["errors"]["email"][0]}")
                  : SizedBox(),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("okay")),
          ],
        );
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text("${response.data["message"]}"),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("okay")),
          ],
        );
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text(e.toString()));
    } finally {
      isLoading(false);
    }
  }
}
