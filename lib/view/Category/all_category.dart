import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

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
                  onTap: () {},
                ),
              ],
            ),
          ),

          /// Coupon Lists
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Stack(
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
                                'Category Name',
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
                      onTap: () {},
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
