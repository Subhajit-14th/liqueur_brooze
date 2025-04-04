import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/addcoupon_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddCouponScreen extends StatelessWidget {
  const AddCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addCouponProvider = Provider.of<AddcouponProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Coupon",
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Coupon Type Dropdownfield
                  Text(
                    "Coupon Type",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: addCouponProvider.selectedCouponType,
                        hint: const Text("Select coupon type"),
                        items: addCouponProvider.couponType.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            addCouponProvider.setCouponType(newValue);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  /// Coupon Code TextField
                  Text(
                    "Coupon Code",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    labelText: 'Enter coupon code',
                    hintText: 'enter cpupon code',
                    controller: addCouponProvider.couponCodeController,
                  ),
                  SizedBox(height: height * 0.02),

                  /// Value Textfield
                  Text(
                    "Value",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    labelText: 'Enter value',
                    hintText: 'enter value',
                    controller: addCouponProvider.valueController,
                  ),
                  SizedBox(height: height * 0.02),

                  /// Start date
                  Text(
                    "Start Date",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    labelText: 'Start Date',
                    hintText: 'Start Date',
                    controller: addCouponProvider.startDateController,
                    suffixIconData: Icons.calendar_month_rounded,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        currentDate: DateTime.now(),
                        initialDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        addCouponProvider.setStartDate(formattedDate);
                      }
                    },
                  ),
                  SizedBox(height: height * 0.02),

                  /// End Date
                  Text(
                    "End Date",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    labelText: 'End Date',
                    hintText: 'End Date',
                    controller: addCouponProvider.endDateController,
                    suffixIconData: Icons.calendar_month_rounded,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        currentDate: DateTime.now(),
                        initialDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        addCouponProvider.setEndDate(formattedDate);
                      }
                    },
                  ),
                  SizedBox(height: height * 0.04),

                  /// Add Coupon Button
                  CommonButton(
                    width: double.infinity,
                    buttonText: 'Add Coupon',
                    buttonColor: AppColor.primaryColor,
                    buttonTextFontSize: 16,
                    onTap: () {
                      DateTime startDateTime = DateFormat("dd/MM/yyyy")
                          .parse(addCouponProvider.startDateController.text);
                      String startDate =
                          startDateTime.toUtc().toIso8601String();
                      DateTime endDateTime = DateFormat("dd/MM/yyyy")
                          .parse(addCouponProvider.endDateController.text);
                      String endDate = endDateTime.toUtc().toIso8601String();

                      var body = {
                        "type":
                            "${addCouponProvider.selectedCouponType?.toLowerCase()}",
                        "code": addCouponProvider.couponCodeController.text,
                        "value": addCouponProvider.valueController.text,
                        "starting_date": startDate,
                        "ending_date": endDate
                      };
                      debugPrint('Code: $body');

                      addCouponProvider.addCoupon(
                          context: context,
                          couponType:
                              "${addCouponProvider.selectedCouponType?.toLowerCase()}",
                          couponCode:
                              addCouponProvider.couponCodeController.text,
                          couponValue:
                              int.parse(addCouponProvider.valueController.text),
                          startDate: startDate,
                          endDate: endDate);
                    },
                  ),
                ],
              ),
            ),
          ),

          /// Loading Indicator Overlay
          if (context.watch<AddcouponProvider>().isAddCoupon)
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
