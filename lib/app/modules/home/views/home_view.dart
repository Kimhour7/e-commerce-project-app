import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comers/app/data/constant/constant.dart';
import 'package:e_comers/app/modules/profile/controllers/profile_controller.dart';
import 'package:e_comers/app/modules/user_screen/controllers/user_screen_controller.dart';
import 'package:e_comers/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final userScreenController = Get.put(UserScreenController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teal,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // Header
              SliverToBoxAdapter(
                child: Obx(
                  () => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.lightBluishTeal,
                      radius: 28,
                      child: profileController.isLoading.value == true
                          ? SizedBox()
                          : CachedNetworkImage(
                              imageUrl:
                                  Constant.baseUrl +
                                  profileController.imageUrl.value,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: imageProvider,
                                  ),
                              placeholder: (context, url) => CircleAvatar(
                                radius: 40,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.cyanTeal,
                                    child: Icon(Icons.person, size: 40),
                                  ),
                            ),
                    ),
                    title: Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      profileController.isLoading.value == true
                          ? "Guest"
                          : profileController.userName.value ?? "Guest",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: badges.Badge(
                      position: controller.favoriteCount > 99
                          ? badges.BadgePosition.topEnd(top: 0, end: -4)
                          : badges.BadgePosition.topEnd(top: 0, end: 0),
                      badgeContent: controller.favoriteCount > 99
                          ? Text(
                              "99+",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              controller.favoriteCount.value.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                      child: IconButton(
                        onPressed: () {
                          controller.favoriteCount.value++;
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Search bar (Pinned)
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                elevation: 2,
                toolbarHeight: 65,
                backgroundColor: AppColors.teal,
                title: GestureDetector(
                  onTap: () => Get.toNamed(Routes.SEARCH_PRODUCT),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.darkTeal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white70),
                        SizedBox(width: 10),
                        Text(
                          "Search for restaurant",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Discount Slider
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: 15,
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) => Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            width: MediaQuery.of(context).size.width,
                            height: 230,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              itemIndex.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {
                          controller.dotIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(height: 10),

                    //Got Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => AnimatedSmoothIndicator(
                            activeIndex: controller.dotIndex.value,
                            count: 15,
                            effect: ExpandingDotsEffect(
                              dotHeight: 7,
                              dotWidth: 7,
                              dotColor: Colors.white,
                              activeDotColor: AppColors.lightBluishTeal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () => controller.getProduct(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Obx(() {
                final data = controller.product.value.data;

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
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No products available",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                // Show product list
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var categories = data[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categories.categoryName ?? "Unknown Category",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("See All Product Action");
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                categories.products == null ||
                                    categories.products!.isEmpty
                                ? 0
                                : categories.products!.length,
                            itemBuilder: (context, index) {
                              var pro = categories.products![index];
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                Constant.baseUrl + pro.image!,
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: AppColors.teal,
                                                      ),
                                                ),
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => Container(
                                                  width: double.infinity,
                                                  color: Colors.grey.shade300,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .broken_image_outlined,
                                                        size: 48,
                                                        color: Colors
                                                            .grey
                                                            .shade600,
                                                      ),

                                                      SizedBox(height: 8),
                                                      Text(
                                                        "Image unavailable",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey
                                                              .shade600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        pro.name ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("\$${pro.price}"),
                                          GestureDetector(
                                            onTap: () async {
                                              await controller.addToCard(
                                                id: pro.id!,
                                                quantity: 1,
                                              );
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
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
