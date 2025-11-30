import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/account_setting_controller.dart';

class AccountSettingView extends GetView<AccountSettingController> {
  const AccountSettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AccountSettingView'),
        centerTitle: true,
      ),
      body: Column(children: []),
    );
  }
}
