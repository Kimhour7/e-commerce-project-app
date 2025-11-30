import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:e_comers/app/service/storage_service.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() async {
    Get.put(StorageService(), permanent: true);
    Get.put(APIProvider(), permanent: true);
  }
}
