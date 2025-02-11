import 'package:flutter/material.dart';

import '../assets/app_colors.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    super.key,
    required this.width,
    required this.buttonText,
    this.height,
    this.onTap,
  });

  final double width;
  final double? height;
  final String buttonText;
  final Function()? onTap;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.height ?? 50,
        width: widget.width,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: AppColor.lightTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ),
    );
  }
}
