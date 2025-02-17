import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final addCategoryProvider = Provider.of<AddCategoryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Category",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Monserat',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Add Sub Category name
            Text(
              'Category Name',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monserat',
              ),
            ),
            SizedBox(height: height * 0.01),
            CommonTextField(
              labelText: 'Enter Category',
              hintText: 'enter category name',
              controller: addCategoryProvider.categoryController,
            ),
            SizedBox(height: height * 0.02),

            /// Add Coupon Button
            CommonButton(
              width: double.infinity,
              buttonText: 'Add',
              buttonColor: AppColor.primaryColor,
              buttonTextFontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
