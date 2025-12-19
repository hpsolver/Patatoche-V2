import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';

import 'image_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final Color backgroundColor;
  final bool centerTitle;
  final Widget? titleWidget;

  const CustomAppBar({
    super.key,
    this.onBack,
    this.backgroundColor = Colors.white,
    this.centerTitle = false,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      titleSpacing: 0,
      title: titleWidget,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: onBack != null
          ? GestureDetector(
              onTap: onBack,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: ImageView(path: AssetsResource.icBack,),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
