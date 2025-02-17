import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/AddCouponScreen/add_coupon_screen.dart';
import 'package:liqueur_brooze/view/DashboardScreen/coupon_delete_dialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
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
                    'All Coupon',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  Text(
                    'Manage your All Coupon',
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
                buttonText: 'Add Coupon',
                buttonColor: AppColor.primaryColor,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCouponScreen()));
                },
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),

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
                        /// Coupon Type Or Coupon Code
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Coupon Type
                            Text(
                              'Coupon Type',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            Text(
                              'Percentage',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(height: height * 0.02),

                            /// Coupon Code
                            Text(
                              'Coupon Code',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            Text(
                              '926F',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                          ],
                        ),

                        /// Value and start date and end date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Value
                            Text(
                              'Value',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            Text(
                              '1600',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(height: height * 0.02),

                            /// Start Date End Date
                            Row(
                              spacing: 14,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        Text(
                                          '12/12/2025',
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End Date',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        Text(
                                          '12/12/2025',
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
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CouponDeleteDialog(),
                      );
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
              );
            },
          ),
        ),
      ],
    );
  }
}
