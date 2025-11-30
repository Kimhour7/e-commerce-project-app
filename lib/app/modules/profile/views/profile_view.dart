import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comers/app/data/constant/constant.dart';
import 'package:e_comers/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/storage_service.dart';
import '../../../theme/color.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileView'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with gradient
              Container(
                height: 176,
                decoration: const BoxDecoration(color: AppColors.cyanTeal),
                child: SafeArea(
                  child: Stack(
                    children: [
                      // Profile section
                      Obx(
                        () => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.isLoading.value == true
                                  ? SizedBox()
                                  : CachedNetworkImage(
                                      imageUrl:
                                          Constant.baseUrl +
                                          controller.imageUrl.value,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: imageProvider,
                                          ),
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                            radius: 40,
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                            radius: 40,
                                            child: Icon(Icons.person, size: 40),
                                          ),
                                    ),
                              const SizedBox(height: 8),
                              controller.isLoading.value == true
                                  ? SizedBox()
                                  : Text(
                                      controller.userName.value,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5),
              // Stats cards
              Transform.translate(
                offset: const Offset(0, -24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          '24',
                          'Orders',
                          const Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          '12',
                          'Wishlist',
                          const Color(0xFF9333EA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          '\$2.4K',
                          'Saved',
                          const Color(0xFFEA580C),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Menu items
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  children: [
                    _buildMenuItem(
                      context,
                      Icons.shopping_bag_outlined,
                      'My Orders',
                      'Track & manage orders',
                      const Color(0xFF3B82F6),
                      const Color(0xFFDBEAFE),
                      badge: '2 New',
                      badgeColor: const Color(0xFFFEE2E2),
                      badgeTextColor: const Color(0xFFDC2626),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.favorite_border,
                      'Wishlist',
                      'Saved items',
                      const Color(0xFFEC4899),
                      const Color(0xFFFCE7F3),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.location_on_outlined,
                      'Addresses',
                      'Manage delivery addresses',
                      const Color(0xFF10B981),
                      const Color(0xFFD1FAE5),
                      onTap: () => Get.toNamed(Routes.ADDRESS),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.credit_card_outlined,
                      'Payment Methods',
                      'Cards & digital wallets',
                      const Color(0xFF9333EA),
                      const Color(0xFFF3E8FF),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.settings_outlined,
                      'Account Settings',
                      'Privacy & preferences',
                      const Color(0xFF6B7280),
                      const Color(0xFFF3F4F6),
                      onTap: () => Get.toNamed(Routes.ACCOUNT_SETTING),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.help_outline,
                      'Help & Support',
                      '24/7 customer service',
                      const Color(0xFFEA580C),
                      const Color(0xFFFFEDD5),
                      onTap: () async {
                        await StorageService.readAllValue();
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.logout,
                      'Sign Out',
                      'Logout from account',
                      const Color(0xFFDC2626),
                      const Color(0xFFFEE2E2),
                      isLast: true,
                      onTap: () {
                        controller.logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatCard(
  BuildContext context,
  String value,
  String label,
  Color color,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
      ],
    ),
  );
}

Widget _buildMenuItem(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  Color iconColor,
  Color backgroundColor, {
  String? badge,
  Color? badgeColor,
  Color? badgeTextColor,
  bool isLast = false,
  VoidCallback? onTap,
}) {
  return InkWell(
    splashColor: Colors.grey.withOpacity(0.3),
    highlightColor: Colors.grey.withOpacity(0.3),
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          if (badge != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  color: badgeTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
        ],
      ),
    ),
  );
}
