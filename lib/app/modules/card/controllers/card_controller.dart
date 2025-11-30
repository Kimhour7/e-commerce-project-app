import 'package:e_comers/app/data/models/CartItem.dart';
import 'package:e_comers/app/data/provider/api_provider.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  final _api = Get.find<APIProvider>();
  Rx<CartItem> cartItem = Rx(CartItem());

  var isLoading = false.obs;

  void getCartItem() async {
    try {
      isLoading(true);
      final response = await _api.getCartItem();
      if (response.statusCode == 200) {
        cartItem(CartItem.fromJson(response.data));
        return;
      }
    } catch (e) {
      print("Error From Cart : ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCart({required int id, required int quantity}) async {
    try {
      isLoading(true);
      final response = await _api.updateCard(id: id, quantity: quantity);
      if (response.statusCode == 200) {
        getCartItem();
        print("Cart Updated");
        return;
      }
      print(response.statusCode);
    } catch (e) {
      print("Error From Cart : ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteCart({required int id}) async {
    try {
      isLoading(true);
      final response = await _api.deleteCard(id: id);
      if (response.statusCode == 200) {
        getCartItem();
        print("Cart Delete");
        return;
      }
      print(response.statusCode);
    } catch (e) {
      print("Error From Cart : ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getCartItem();
    super.onInit();
  }
}
