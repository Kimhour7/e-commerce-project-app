import 'package:e_comers/app/data/models/Address.dart';
import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final _api = Get.find<APIProvider>();
  Rx<Address> address = Rx(Address());

  void getAddress() async {
    try {
      final response = await _api.getAddress();
      if (response.statusCode == 200) {
        address(Address.fromJson(response.data));
        return;
      }
    } catch (e) {
      print("Error From Address : ${e.toString()}");
    }
  }

  void deleteAddress() async {
    Get.defaultDialog(
      title: "Warning",
      content: Text("Are you sure to delete this address"),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
        TextButton(
          onPressed: () {},
          child: Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  @override
  void onInit() {
    getAddress();
    super.onInit();
  }
}
