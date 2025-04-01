import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/AddCouponScreen/add_coupon_screen.dart';
import 'package:liqueur_brooze/view/AddCouponScreen/edit_coupon_screen.dart';
import 'package:liqueur_brooze/view/DashboardScreen/coupon_delete_dialog.dart';
import 'package:liqueur_brooze/viewModel/addcoupon_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class AllCouponScreen extends StatefulWidget {
  const AllCouponScreen({super.key});

  @override
  State<AllCouponScreen> createState() => _AllCouponScreenState();
}

class _AllCouponScreenState extends State<AllCouponScreen> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddcouponProvider>(context, listen: false)
          .getAllCoupon(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Coupon",
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
          Consumer<AddcouponProvider>(
              builder: (context, couponProvider, child) {
            if (couponProvider.isCouponLoad) {
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
                itemCount: couponProvider.allCouponData?.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  // Format as DD/MM/YYYY
                  String formattedStart = DateFormat("dd/MM/yyyy").format(
                      DateTime.parse(
                          '${couponProvider.allCouponData?[index].startingDate}'));
                  String formattedEnd = DateFormat("dd/MM/yyyy").format(
                      DateTime.parse(
                          '${couponProvider.allCouponData?[index].endingDate}'));
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditCouponScreen(
                                    couponId:
                                        "${couponProvider.allCouponData?[index].sId}",
                                    updatedCouponType:
                                        "${couponProvider.allCouponData?[index].type}",
                                    updaedCouponCode:
                                        "${couponProvider.allCouponData?[index].code}",
                                    updaedCouponValue:
                                        "${couponProvider.allCouponData?[index].value}",
                                    updaedCouponStartDate: formattedStart,
                                    updaedCouponEndDate: formattedEnd,
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
                                    'Coupon Type',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    '${couponProvider.allCouponData?[index].type}',
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
                                    '${couponProvider.allCouponData?[index].code}',
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
                                    '${couponProvider.allCouponData?[index].value}',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                formattedStart,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                formattedEnd,
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
                              builder: (context) => CouponDeleteDialog(
                                couponId:
                                    "${couponProvider.allCouponData?[index].sId}",
                              ),
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
}
