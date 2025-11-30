import 'package:e_comers/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/color.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AddressView'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async => controller.getAddress(),
        child: Obx(() {
          var data = controller.address.value.addresses;

          if (data == null) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.teal),
            );
          }

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Address Found.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var data = controller.address.value.addresses?[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.location_on),
                ),
                title: Text(data?.city ?? "Not Found"),
                subtitle: Text(
                  data!.country ?? "Not Found",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: AppColors.cyanTeal),
                    ),
                    IconButton(
                      onPressed: () => controller.deleteAddress(),
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_ADDRESS),
        child: Center(child: Icon(Icons.add)),
      ),
    );
  }
}
