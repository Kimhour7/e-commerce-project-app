import 'package:e_comers/app/dependency_injection.dart';
import 'package:e_comers/app/service/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'app/utils/awesomeNotificationsHelper.dart';
import 'app/utils/fcm_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FcmHelper.initFcm();
  await AwesomeNotificationsHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DependencyInjection.init();
  var token = await StorageService.read(key: 'token');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Comers",
      theme: AppTheme.lightTheme,
      initialRoute: token != null ? Routes.USER_SCREEN : Routes.LOGIN,
      // initialRoute: Routes.TEST,
      getPages: AppPages.routes,
    ),
  );
}
