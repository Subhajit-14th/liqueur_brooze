import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class AddSubCategory extends StatefulWidget {
  const AddSubCategory({super.key});

  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddCategoryProvider>(context, listen: false)
          .getCategoryList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add SubCategory",
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
      body: context.watch<AddCategoryProvider>().isLoading
          ? Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballZigZag,
                  colors: [AppColor.primaryColor, AppColor.secondaryColor],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.black,
                ),
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Add Category name
                      Text(
                        'Category Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monserat',
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        height: 60, // Increase this height if needed
                        child: DropdownButtonFormField<String>(
                          value: context
                              .read<AddSubCategoryProvider>()
                              .selectedAddSubCategoryValue,
                          hint: const Text("Choose a category"),
                          items: context
                              .read<AddCategoryProvider>()
                              .allCategories
                              ?.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.catagoryname,
                              child: Text(
                                category.catagoryname ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            var selectedCategory = context
                                .read<AddCategoryProvider>()
                                .allCategories
                                ?.firstWhere((category) =>
                                    category.catagoryname == value);
                            if (selectedCategory != null) {
                              context
                                  .read<AddSubCategoryProvider>()
                                  .setSubCategory(
                                    selectedCategory.catagoryname!,
                                    selectedCategory.sId!,
                                  );
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 14), // Increase vertical padding
                          ),
                          menuMaxHeight: 300, // Increase dropdown height
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      /// Add Sub Category name
                      Text(
                        'SubCategory Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monserat',
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      CommonTextField(
                        labelText: 'Enter SubCategory',
                        hintText: 'enter sub category name',
                        controller: context
                            .read<AddSubCategoryProvider>()
                            .subCategoryController,
                      ),
                      SizedBox(height: height * 0.02),

                      /// Add Coupon Button
                      CommonButton(
                        width: double.infinity,
                        buttonText: 'Add',
                        buttonColor: AppColor.primaryColor,
                        buttonTextFontSize: 16,
                        onTap: () {
                          context.read<AddSubCategoryProvider>().addSubcategory(
                              context,
                              context
                                  .read<AddSubCategoryProvider>()
                                  .selectedSubCategoryId,
                              context
                                  .read<AddSubCategoryProvider>()
                                  .subCategoryController
                                  .text);
                        },
                      ),
                    ],
                  ),
                ),
                if (context.watch<AddSubCategoryProvider>().isSubCategoryAdd)
                  Container(
                    height: height,
                    width: width,
                    color: Colors.black.withAlpha(50), // Dim background
                    child: const Center(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballZigZag,
                          colors: [
                            AppColor.primaryColor,
                            AppColor.secondaryColor
                          ],
                          strokeWidth: 2,
                          backgroundColor: Colors.transparent,
                          pathBackgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
