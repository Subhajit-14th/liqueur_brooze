import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:provider/provider.dart';

class AddSubCategory extends StatelessWidget {
  const AddSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final addSubCategoryProvider = Provider.of<AddSubCategoryProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Sub Category",
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
            /// Add Sub Category Heading
            Text(
              'Category',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monserat',
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.6,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: addSubCategoryProvider.selectedAddSubCategoryValue,
                  hint: const Text("Select coupon type"),
                  items: addSubCategoryProvider.addSubCategoryValue
                      .map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      addSubCategoryProvider.setSubCategory(newValue);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            /// Add Sub Category name
            Text(
              'Sub Category Name',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monserat',
              ),
            ),
            SizedBox(height: height * 0.01),
            CommonTextField(
              labelText: 'Enter Sub Category',
              hintText: 'enter sub category name',
              controller: addSubCategoryProvider.subCategoryController,
            ),
            SizedBox(height: height * 0.02),

            /// Submit Button
            CommonButton(
              width: double.infinity,
              buttonText: 'Submit',
              buttonColor: AppColor.primaryColor,
              buttonTextFontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
