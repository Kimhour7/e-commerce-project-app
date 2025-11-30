import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/color.dart';
import '../controllers/signup_controller.dart';

final signupController = Get.put(SignupController());

Widget signupWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Username
      SizedBox(
        height: 43,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Text("Username", style: TextStyle(color: Colors.grey)),
              prefixIcon: Icon(Icons.person),
              hintStyle: TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              signupController.usernameText.value = "";
              signupController.usernameText.value = value;
            },
          ),
        ),
      ),
      const SizedBox(height: 20),

      //Email
      SizedBox(
        height: 43,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Text(
                "example@gmail.com",
                style: TextStyle(color: Colors.grey),
              ),
              prefixIcon: Icon(Icons.email),
              hintStyle: TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              signupController.emailText.value = "";
              signupController.emailText.value = value;
            },
          ),
        ),
      ),
      const SizedBox(height: 20),

      // Phone number
      SizedBox(
        height: 43,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Text("Phone Number", style: TextStyle(color: Colors.grey)),
              prefixIcon: Icon(Icons.phone),
              hintStyle: TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              signupController.phoneText.value = "";
              signupController.phoneText.value = value;
            },
          ),
        ),
      ),
      const SizedBox(height: 20),

      // Password
      SizedBox(
        height: 43,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Obx(
            () => TextField(
              style: TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                hint: Text("Password", style: TextStyle(color: Colors.grey)),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () => signupController.toggleObscurePassword(),
                  icon: Icon(
                    signupController.isObscurePassword.value == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                hintStyle: TextStyle(color: Colors.white),
              ),
              obscureText: signupController.isObscurePassword.value,
              onChanged: (value) {
                signupController.passwordText.value = "";
                signupController.passwordText.value = value;
              },
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),

      // Signup Button
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
            signupController.register(
              name: signupController.usernameText.value,
              email: signupController.emailText.value,
              phone: signupController.phoneText.value,
              password: signupController.passwordText.value,
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
