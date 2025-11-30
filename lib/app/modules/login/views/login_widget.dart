import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../service/storage_service.dart';
import '../../../theme/color.dart';
import '../controllers/login_controller.dart';

final LoginController loginController = Get.put(LoginController());

Widget loginWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //Phone TextField
      const Text(
        "Email",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        height: 43,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8),
          child: TextField(
            style: TextStyle(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              hintText: "example@gmail.com",
              prefixIcon: Icon(Icons.person),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              loginController.emailText.value = "";
              loginController.emailText.value = value;
            },
          ),
        ),
      ),

      const SizedBox(height: 20),

      //Password
      const Text(
        "Password",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        height: 43,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Obx(
            () => TextField(
              style: TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () => loginController.toggleObscureText(),
                  icon: Icon(
                    loginController.isObscureText.value == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                ),
              ),
              obscureText: loginController.isObscureText.value,
              onChanged: (value) {
                loginController.passwordText.value = "";
                loginController.passwordText.value = value;
              },
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

      //Login Button
      SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            //TODO
            print(loginController.emailText.value);
            print(loginController.passwordText.value);
            loginController.login(
              email: loginController.emailText.value,
              password: loginController.passwordText.value,
            );
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      const SizedBox(height: 20),

      // OR Divider
      const Row(
        children: [
          Expanded(child: Divider(color: Colors.white38, thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("OR", style: TextStyle(color: Colors.white70)),
          ),
          Expanded(child: Divider(color: Colors.white38, thickness: 1)),
        ],
      ),
      const SizedBox(height: 20),

      // Google Login Button
      SizedBox(
        width: double.infinity,
        height: 40,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: AppColors.teal),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: Icon(Bootstrap.google),
          label: const Text("Login with Google"),
          onPressed: () {
            print(StorageService.readAllValue().toString());
          },
        ),
      ),
    ],
  );
}
