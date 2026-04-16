import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicknotes/core/constants/color_manager.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              backgroundColor ?? ColorManager.primary,
            ),
            elevation: WidgetStateProperty.all(0),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 14.h),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
          child: Text(
            title,
            style:
                style ??
                TextStyle(
                  fontSize: 18.sp,
                  color: textColor ?? ColorManager.white,
                ),
          ),
        ),
      ),
    );
  }
}
