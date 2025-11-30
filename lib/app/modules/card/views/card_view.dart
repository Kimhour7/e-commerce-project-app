import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comers/app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/constant.dart';
import '../controllers/card_controller.dart';

class CardView extends GetView<CardController> {
  const CardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CardView'), centerTitle: true),
      body: Obx(() {
        var data = controller.cartItem.value.cartItems;

        if (data == null) {
          return Center(child: Text("No Cart Found"));
        }

        if (data.isEmpty) {
          return Center(child: Text("No Cart Found"));
        }

        return controller.isLoading == true
            ? Center(child: CircularProgressIndicator(color: AppColors.teal))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        Constant.baseUrl + item.product!.image!,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.teal,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.broken_image_outlined,
                                                size: 48,
                                                color: Colors.grey.shade600,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "Unavailable",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        item.product!.name ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text("${item.product!.price}\$"),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              int updateQuantity =
                                                  item.quantity!;
                                              updateQuantity--;
                                              if (updateQuantity == 0) {
                                                controller.deleteCart(
                                                  id: item.id!,
                                                );
                                              } else {
                                                controller.updateCart(
                                                  id: item.id!,
                                                  quantity: updateQuantity,
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.remove),
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            iconSize: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(item.quantity.toString() ?? ""),
                                          SizedBox(width: 8),
                                          IconButton(
                                            onPressed: () {
                                              int updateQuantity =
                                                  item.quantity!;
                                              updateQuantity++;
                                              controller.updateCart(
                                                id: item.id!,
                                                quantity: updateQuantity,
                                              );
                                            },
                                            icon: Icon(Icons.add),
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            iconSize: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Summary",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Total Item   ${data.length}"),
                          Text(
                            "SubTotal  ${controller.cartItem.value.cart!.total}\$",
                          ),
                          Text("Shipping 0\$"),
                          SizedBox(height: 10),
                          Divider(height: 10, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "Total Price   ${controller.cartItem.value.cart!.total}\$",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              //TODO
                              print("Check Out");
                            },
                            child: Text(
                              "Check Out",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
