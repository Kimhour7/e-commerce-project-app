import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:e_comers/app/modules/login/views/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final _api = Get.find<APIProvider>();
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;

  var usernameText = "".obs;
  var emailText = "".obs;
  var phoneText = "".obs;
  var passwordText = "".obs;

  void toggleObscurePassword() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void toggleObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      loginController.isLoading(true);
      final response = await _api.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      if (response.statusCode == 200) {
        Get.defaultDialog(
          title: "Successes",
          content: Text("User Created Successfully. Please Login"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Get.back(), child: Text("okay")),
              ],
            ),
          ],
        );
        loginController.isLoginClicked.value = true;
        loginController.isSignupClicked.value = false;
      } else if (response.statusCode == 422) {
        Get.defaultDialog(
          title: "Error",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              response.data['errors']['name'] != null
                  ? Text("${response.data['errors']['name'][0]}")
                  : SizedBox(),
              response.data['errors']['email'] != null
                  ? Text("${response.data['errors']['email'][0]}")
                  : SizedBox(),
              response.data['errors']['phone'] != null
                  ? Text("${response.data['errors']['phone'][0]}")
                  : SizedBox(),
              response.data['errors']['password'] != null
                  ? Text("${response.data['errors']['password'][0]}")
                  : SizedBox(),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Get.back(), child: Text("okay")),
              ],
            ),
          ],
        );
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text(e.toString()));
    } finally {
      loginController.isLoading(false);
    }
  }
}
