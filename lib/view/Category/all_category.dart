import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/Category/add_category.dart';
import 'package:liqueur_brooze/view/Category/update_category_screen.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Category",
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
                Text(
                  'All Category',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monserat',
                  ),
                ),
                CommonButton(
                  width: 130,
                  height: 40,
                  buttonText: 'Add Category',
                  buttonTextFontSize: 12,
                  buttonColor: AppColor.primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCategoryScreen()));
                  },
                ),
              ],
            ),
          ),

          /// Coupon Lists
          Consumer<AddCategoryProvider>(builder: (context, provider, child) {
            if (provider.isLoading) {
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
                itemCount: provider.allCategories?.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateCategoryScreen(
                                    categoryId:
                                        "${provider.allCategories?[index].sId}",
                                    categoryName:
                                        "${provider.allCategories?[index].catagoryname}",
                                  )));
                    },
                    highlightColor: Colors.transparent,
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
                              Column(
                                children: [
                                  Text(
                                    'SL',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                ],
                              ),

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
                                    '${provider.allCategories?[index].catagoryname}',
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
                                "${provider.allCategories?[index].sId}");
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

  void _showDeleteDialog(BuildContext context, String categoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Category",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserat',
            ),
          ),
          content: Text(
            "Are you sure you want to delete this category?",
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
                Provider.of<AddCategoryProvider>(context, listen: false)
                    .deleteCategory(context, categoryId);
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
