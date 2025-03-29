import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryId;
  final String categoryName;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddCategoryProvider>(context, listen: false)
        .updateCategoryNameController
        .text = widget.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final addCategoryProvider = Provider.of<AddCategoryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Update Category",
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
      body: context.watch<AddCategoryProvider>().isCategoryUpdate
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
          : Padding(
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
                    controller:
                        addCategoryProvider.updateCategoryNameController,
                  ),
                  SizedBox(height: height * 0.02),

                  /// Add Coupon Button
                  CommonButton(
                    width: double.infinity,
                    buttonText: 'Update',
                    buttonColor: AppColor.secondaryColor,
                    buttonTextFontSize: 16,
                    onTap: () {
                      addCategoryProvider.updateCategoryList(
                          context,
                          widget.categoryId,
                          addCategoryProvider
                              .updateCategoryNameController.text);
                      if (context.mounted) {
                        Future.delayed(
                          Duration(seconds: 1),
                          () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
