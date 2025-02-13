import 'package:flutter/material.dart';

import '../assets/app_colors.dart';

class CommonPasswordField extends StatefulWidget {
  const CommonPasswordField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  @override
  State<CommonPasswordField> createState() => _CommonPasswordFieldState();
}

class _CommonPasswordFieldState extends State<CommonPasswordField> {
  bool isNotShow = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isNotShow,
      cursorColor: AppColor.darkTextColor,
      style: const TextStyle(
        color: AppColor.lightTextColor,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: AppColor.secondaryColor,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColor.secondaryColor,
        ),
        focusColor: Colors.black,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isNotShow = !isNotShow;
            });
          },
          icon: Icon(
            isNotShow ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            color: AppColor.secondaryColor,
          ),
        ),
      ),
    );
  }
}
