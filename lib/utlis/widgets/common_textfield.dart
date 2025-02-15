import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.onTap,
      this.suffixIconData});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Function()? onTap;
  final IconData? suffixIconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      readOnly: onTap == null ? false : true,
      style: const TextStyle(
        color: Colors.black,
      ),
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColor.secondaryColor,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColor.secondaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusColor: Colors.black,
        suffixIcon: suffixIconData != null
            ? Icon(
                suffixIconData,
                color: AppColor.secondaryColor,
              )
            : SizedBox(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColor.secondaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
