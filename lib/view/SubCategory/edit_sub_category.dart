import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class EditSubCategoryScreen extends StatefulWidget {
  const EditSubCategoryScreen(
      {super.key,
      required this.categoryName,
      required this.subCategoryname,
      required this.categoryNameId,
      required this.subCategoryId});
  final String categoryName;
  final String categoryNameId;
  final String subCategoryname;
  final String subCategoryId;

  @override
  State<EditSubCategoryScreen> createState() => _EditSubCategoryScreenState();
}

class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddCategoryProvider>(context, listen: false)
          .getCategoryList(context);
      Provider.of<AddSubCategoryProvider>(context, listen: false)
          .setUpdatedSubcategory(widget.categoryName, widget.categoryNameId);
      Provider.of<AddSubCategoryProvider>(context, listen: false)
          .updatedSubCategoryController
          .text = widget.subCategoryname;
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
          "Edit SubCategory",
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
                              .selectedUpdatedSubCategoryValue,
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
                                  .setUpdatedSubcategory(
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
                            .updatedSubCategoryController,
                      ),
                      SizedBox(height: height * 0.02),

                      /// Add Coupon Button
                      CommonButton(
                        width: double.infinity,
                        buttonText: 'Update',
                        buttonColor: AppColor.primaryColor,
                        buttonTextFontSize: 16,
                        onTap: () {
                          context
                              .read<AddSubCategoryProvider>()
                              .updateSubCategory(
                                  context,
                                  widget.subCategoryId,
                                  context
                                      .read<AddSubCategoryProvider>()
                                      .selectedUpdatedSubCategoryId,
                                  context
                                      .read<AddSubCategoryProvider>()
                                      .updatedSubCategoryController
                                      .text);
                        },
                      ),
                    ],
                  ),
                ),
                if (context.watch<AddSubCategoryProvider>().isSubCategoryUpdate)
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
