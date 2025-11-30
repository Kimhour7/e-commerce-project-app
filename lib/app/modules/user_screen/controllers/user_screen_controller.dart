import 'package:e_comers/app/modules/card/bindings/card_binding.dart';
import 'package:e_comers/app/modules/card/views/card_view.dart';
import 'package:e_comers/app/modules/home/bindings/home_binding.dart';
import 'package:e_comers/app/modules/home/views/home_view.dart';
import 'package:e_comers/app/modules/profile/bindings/profile_binding.dart';
import 'package:e_comers/app/modules/profile/views/profile_view.dart';
import 'package:e_comers/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../search_product/bindings/search_product_binding.dart';
import '../../search_product/views/search_product_view.dart';

class UserScreenController extends GetxController {
  var selectedIndex = 0.obs;
  var listRouteName = [
    Routes.HOME,
    Routes.SEARCH_PRODUCT,
    Routes.CARD,
    Routes.PROFILE,
  ];

  void onPageChange(index) {
    if (selectedIndex.value == index) {
    } else {
      selectedIndex.value = index;
      Get.offAndToNamed(listRouteName[selectedIndex.value], id: 1);
    }
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.SEARCH_PRODUCT) {
      return GetPageRoute(
        settings: settings,
        page: () => const SearchProductView(),
        binding: SearchProductBinding(),
      );
    }

    if (settings.name == Routes.CARD) {
      return GetPageRoute(
        settings: settings,
        page: () => CardView(),
        binding: CardBinding(),
      );
    }

    if (settings.name == Routes.PROFILE) {
      return GetPageRoute(
        binding: ProfileBinding(),
        settings: settings,
        page: () => ProfileView(),
      );
    }

    if (settings.name == Routes.HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => HomeView(),
        binding: HomeBinding(),
      );
    }
  }
}
