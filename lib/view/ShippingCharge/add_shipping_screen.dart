import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/shipping_charges_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class AddShippingScreen extends StatelessWidget {
  const AddShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final shippingProvider = Provider.of<ShippingChargesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Shipping",
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Pincode Field
                Text(
                  'Pin Code',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monserat',
                  ),
                ),
                SizedBox(height: height * 0.01),
                CommonTextField(
                  labelText: 'Enter Pin Code',
                  hintText: 'enter pin code',
                  controller: shippingProvider.pinCodeController,
                ),
                SizedBox(height: height * 0.02),

                /// Shipping Amount
                Text(
                  'Shipping Amount',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monserat',
                  ),
                ),
                SizedBox(height: height * 0.01),
                CommonTextField(
                  labelText: 'Enter Shipping Amount',
                  hintText: 'enter shipping amount',
                  controller: shippingProvider.shippingController,
                ),
                SizedBox(height: height * 0.02),

                /// Add Shipping Button
                CommonButton(
                  width: double.infinity,
                  buttonText: 'Submit',
                  buttonColor: AppColor.primaryColor,
                  buttonTextFontSize: 16,
                  onTap: () {
                    shippingProvider.addShippingCharge(
                        context,
                        shippingProvider.pinCodeController.text,
                        shippingProvider.shippingController.text);
                  },
                ),
              ],
            ),
          ),

          /// Loading Indicator Overlay
          if (context.watch<ShippingChargesProvider>().isAddShipping)
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
                    colors: [AppColor.primaryColor, AppColor.secondaryColor],
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
