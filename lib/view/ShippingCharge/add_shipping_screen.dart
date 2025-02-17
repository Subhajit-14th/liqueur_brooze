import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/shipping_charges_provider.dart';
import 'package:provider/provider.dart';

class AddShippingScreen extends StatelessWidget {
  const AddShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
      body: Padding(
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
              controller: shippingProvider.pinCodeController,
            ),
            SizedBox(height: height * 0.02),

            /// Add Shipping Button
            CommonButton(
              width: double.infinity,
              buttonText: 'Submit',
              buttonColor: AppColor.primaryColor,
              buttonTextFontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
