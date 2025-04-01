import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/addcoupon_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class EditCouponScreen extends StatefulWidget {
  const EditCouponScreen(
      {super.key,
      required this.updatedCouponType,
      required this.updaedCouponCode,
      required this.updaedCouponValue,
      required this.updaedCouponStartDate,
      required this.updaedCouponEndDate,
      required this.couponId});

  final String couponId;
  final String updatedCouponType;
  final String updaedCouponCode;
  final String updaedCouponValue;
  final String updaedCouponStartDate;
  final String updaedCouponEndDate;

  @override
  State<EditCouponScreen> createState() => _EditCouponScreenState();
}

class _EditCouponScreenState extends State<EditCouponScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddcouponProvider>(context, listen: false)
        .setUpdatedCouponType(_capitalize(widget.updatedCouponType));

    Provider.of<AddcouponProvider>(context, listen: false)
        .updatedCouponCodeController
        .text = widget.updaedCouponCode;
    Provider.of<AddcouponProvider>(context, listen: false)
        .updateValueController
        .text = widget.updaedCouponValue;
    Provider.of<AddcouponProvider>(context, listen: false)
        .updatedStartDateController
        .text = widget.updaedCouponStartDate;
    Provider.of<AddcouponProvider>(context, listen: false)
        .updateEndDateController
        .text = widget.updaedCouponEndDate;
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text; // Return empty if the string is empty
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final addCouponProvider = Provider.of<AddcouponProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Coupon",
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
                        value: addCouponProvider.selectedUpdateCouponType,
                        hint: const Text("Select coupon type"),
                        items: addCouponProvider.couponType.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            addCouponProvider.setUpdatedCouponType(newValue);
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
                    controller: addCouponProvider.updatedCouponCodeController,
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
                    controller: addCouponProvider.updateValueController,
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
                    controller: addCouponProvider.updatedStartDateController,
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
                        addCouponProvider.setUpdateStartDate(formattedDate);
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
                    controller: addCouponProvider.updateEndDateController,
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
                        addCouponProvider.setUpdateEndDate(formattedDate);
                      }
                    },
                  ),
                  SizedBox(height: height * 0.04),

                  /// Add Coupon Button
                  CommonButton(
                    width: double.infinity,
                    buttonText: 'Edit Coupon',
                    buttonColor: AppColor.primaryColor,
                    buttonTextFontSize: 16,
                    onTap: () {
                      DateTime startDateTime = DateFormat("dd/MM/yyyy").parse(
                          addCouponProvider.updatedStartDateController.text);
                      String startDate =
                          startDateTime.toUtc().toIso8601String();
                      DateTime endDateTime = DateFormat("dd/MM/yyyy").parse(
                          addCouponProvider.updateEndDateController.text);
                      String endDate = endDateTime.toUtc().toIso8601String();

                      var body = {
                        "type":
                            "${addCouponProvider.selectedUpdateCouponType?.toLowerCase()}",
                        "code":
                            addCouponProvider.updatedCouponCodeController.text,
                        "value": addCouponProvider.updateValueController.text,
                        "starting_date": startDate,
                        "ending_date": endDate
                      };
                      debugPrint('Code: $body');

                      addCouponProvider.updateCoupon(
                          context: context,
                          couponId: widget.couponId,
                          couponType:
                              "${addCouponProvider.selectedUpdateCouponType?.toLowerCase()}",
                          couponCode: addCouponProvider
                              .updatedCouponCodeController.text,
                          couponValue: int.parse(
                              addCouponProvider.updateValueController.text),
                          startDate: startDate,
                          endDate: endDate);
                    },
                  ),
                ],
              ),
            ),
          ),

          /// Loading Indicator Overlay
          if (context.watch<AddcouponProvider>().isUpdateCoupon)
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
