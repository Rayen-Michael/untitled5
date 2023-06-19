import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NxBottomNavBar extends StatelessWidget {
  const NxBottomNavBar({
    Key? key,
    this.height,
    this.bgColor,
    this.borderRadius,
    this.padding,
    this.margin,
  }) : super(key: key);

  final double? height;
  final Color? bgColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (logic) {
        return SafeArea(
          child: Container(
            height: height ?? Dimens.fiftySix,
            width: Dimens.screenWidth,
            padding: padding ?? Dimens.edgeInsets12,
            decoration: BoxDecoration(
              color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: Dimens.pointEight,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHomeIconBtn(logic, context),
                _buildTrendingIconBtn(logic, context),
                _buildNotificationIconBtn(logic, context),

              ],
            ),
          ),
        );
      },
    );
  }

  GetBuilder<NotificationController> _buildNotificationIconBtn(
      HomeController logic, BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (con) {
        var isUnreadNotification =
            con.notificationList.map((e) => e.isRead).contains(false) ||
                con.followRequestController.followRequestList.isNotEmpty;

        return BottomNavItem(
          icon: Icons.notifications,
          iconColor: Theme.of(context).textTheme.bodyLarge!.color,
          isActive: logic.currentPageIndex == 3,
          itemsCount: 5,
          onTap: () => logic.changePage(3),
          showBadge: isUnreadNotification ? true : false,
        );
      },
    );
  }

  BottomNavItem _buildTrendingIconBtn(
      HomeController logic, BuildContext context) {
    return BottomNavItem(
      icon: Icons.numbers,
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      isActive: logic.currentPageIndex == 1,
      itemsCount: 5,
      onTap: () => logic.changePage(1),
    );
  }


  BottomNavItem _buildHomeIconBtn(HomeController logic, BuildContext context) {
    return BottomNavItem(
      icon: Icons.home,
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      isActive: logic.currentPageIndex == 0,
      itemsCount: 5,
      onTap: () => logic.changePage(0),
    );
  }
}
