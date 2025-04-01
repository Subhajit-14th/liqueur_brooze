import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/viewModel/addcoupon_provider.dart';
import 'package:provider/provider.dart';

class CouponDeleteDialog extends StatelessWidget {
  const CouponDeleteDialog({super.key, required this.couponId});

  final String couponId;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 28),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Are you want to sure to delete this coupon?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: CommonButton(
                          width: 130,
                          height: 35,
                          buttonText: 'No',
                          buttonTextFontSize: 16,
                          buttonColor: AppColor.secondaryColor,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: CommonButton(
                          width: 130,
                          height: 35,
                          buttonText: 'Yes',
                          buttonTextFontSize: 16,
                          buttonColor: AppColor.secondaryColor,
                          onTap: () {
                            Navigator.pop(context);
                            context
                                .read<AddcouponProvider>()
                                .deleteCoupon(context, couponId);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
