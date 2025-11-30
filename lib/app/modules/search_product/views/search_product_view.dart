import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/constant.dart';
import '../../../theme/color.dart';
import '../controllers/search_product_controller.dart';

class SearchProductView extends GetView<SearchProductController> {
  const SearchProductView({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchFocusNode.requestFocus();
      controller.searchTextController.clear();
      controller.searchText.value = "";
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Search bar
            Expanded(
              child: SizedBox(
                height: 43,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: TextField(
                    controller: controller.searchTextController,
                    focusNode: controller.searchFocusNode,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here...",
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    onChanged: (value) {
                      controller.searchTextController.text = value;
                      controller.searchText.value = value;
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        controller.searchProduct(
                          keyword: controller.searchTextController.text,
                        );
                      }
                      controller.product.clear();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 260,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: controller.product.length,
                  itemBuilder: (context, index) {
                    var data = controller.product[index];
                    return Container(
                      padding: EdgeInsetsGeometry.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: Constant.baseUrl + data.image!,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.teal,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image_outlined,
                                        size: 48,
                                        color: Colors.grey.shade600,
                                      ),

                                      SizedBox(height: 8),
                                      Text(
                                        "Image unavailable",
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
                          ),
                          Text(
                            data.name ?? "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${data.price}"),
                              GestureDetector(
                                onTap: () {
                                  print("add to cards");
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.teal,
                                  child: Icon(Icons.add, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
