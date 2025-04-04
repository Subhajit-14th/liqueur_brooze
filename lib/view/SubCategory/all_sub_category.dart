import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/SubCategory/add_sub_category.dart';
import 'package:liqueur_brooze/view/SubCategory/edit_sub_category.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class AllSubCategory extends StatefulWidget {
  const AllSubCategory({super.key});

  @override
  State<AllSubCategory> createState() => _AllSubCategoryState();
}

class _AllSubCategoryState extends State<AllSubCategory> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddSubCategoryProvider>(context, listen: false)
          .getAllSubCategory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sub Category",
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
      body: Column(
        children: [
          /// Heading items and add coupon buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Sub Category',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monserat',
                      ),
                    ),
                    Text(
                      'Manage your All SubCategory',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Monserat',
                      ),
                    ),
                  ],
                ),
                CommonButton(
                  width: 130,
                  height: 40,
                  buttonText: 'Add Sub Category',
                  buttonTextFontSize: 12,
                  buttonColor: AppColor.primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSubCategory()));
                  },
                ),
              ],
            ),
          ),

          /// Coupon Lists
          Consumer<AddSubCategoryProvider>(
              builder: (context, subCategoryProvider, child) {
            if (subCategoryProvider.isSubCategoryLoad) {
              return const Center(
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
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: subCategoryProvider.allSubCategory?.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditSubCategoryScreen(
                                    categoryName:
                                        "${subCategoryProvider.allSubCategory?[index].category?.catagoryname}",
                                    categoryNameId:
                                        "${subCategoryProvider.allSubCategory?[index].category?.sId}",
                                    subCategoryname:
                                        "${subCategoryProvider.allSubCategory?[index].name}",
                                    subCategoryId:
                                        "${subCategoryProvider.allSubCategory?[index].sId}",
                                  )));
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(50),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            spacing: 18,
                            children: [
                              /// Coupon Type Or Coupon Code
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Coupon Type
                                  Text(
                                    'Category',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    '${subCategoryProvider.allSubCategory?[index].category?.catagoryname}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                ],
                              ),

                              /// Sub category name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Value
                                  Text(
                                    'Sub Category',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    '${subCategoryProvider.allSubCategory?[index].name}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showDeleteDialog(context,
                                "${subCategoryProvider.allSubCategory?[index].sId}");
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(14),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String subCategoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete SubCategory",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserat',
            ),
          ),
          content: Text(
            "Are you sure you want to delete this SubCategory?",
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Monserat',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Monserat',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AddSubCategoryProvider>(context, listen: false)
                    .deleteSubCategory(context, subCategoryId);
                Navigator.of(context).pop(); // Close the dialog after deleting
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Monserat',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
