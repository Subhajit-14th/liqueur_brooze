import 'package:flutter/material.dart';
import 'package:liqueur_brooze/admin_panel.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/viewModel/dashboard_screen_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardScreenProvider =
        Provider.of<DashboardScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      drawer: const AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            /// Add Coupon Text And Button
            Row(
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
                )
              ],
            ),
            SizedBox(height: height * 0.02),

            /// Coupon Items
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColor.secondaryColor,
                  strokeAlign: 0.6,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      /// Filter Icon
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.filter_alt_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),

                      /// PDF Button
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 28,
                      ),
                      SizedBox(width: width * 0.02),

                      /// List Button
                      Icon(
                        Icons.list_alt_rounded,
                        color: Colors.green,
                        size: 28,
                      ),
                      SizedBox(width: width * 0.02),

                      /// Print Button
                      Icon(
                        Icons.print_rounded,
                        color: Colors.grey,
                        size: 28,
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),

                  /// Heading
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'SL',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              'Coupon type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              'Coupon Code',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              'Value',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              'Start Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              'Ending Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              'Action',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monserat',
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0;
                            i < dashboardScreenProvider.couponItems.length;
                            i++) ...{
                          Row(
                            children: [
                              Text(
                                '${i + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                dashboardScreenProvider
                                    .couponItems[i].couponType,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                dashboardScreenProvider
                                    .couponItems[i].couponCode,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                dashboardScreenProvider.couponItems[i].value,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                dashboardScreenProvider
                                    .couponItems[i].startDate,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                dashboardScreenProvider
                                    .couponItems[i].endingDate,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                'Action',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monserat',
                                ),
                              ),
                            ],
                          ),
                        },
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
