import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/product_provider.dart';
import 'package:provider/provider.dart';

class AttributesScreen extends StatelessWidget {
  const AttributesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (context.watch<ProductProvider>().attributeList ?? []).isEmpty
            ? SizedBox()
            : const Text(
                "Attributes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
        const SizedBox(height: 10),
        Consumer<ProductProvider>(builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.attributeList?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CommonTextField(
                        labelText:
                            provider.attributeList?[index].attributeName ?? "",
                        hintText:
                            provider.attributeList?[index].attributeName ?? "",
                        controller: provider.attributeList?[index]
                                .attributeNameController ??
                            TextEditingController(),
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        width: 100,
                        buttonText: 'Add Value',
                        buttonColor: AppColor.primaryColor,
                        buttonTextFontSize: 16,
                        onTap: () {
                          provider.addValues(
                              index,
                              provider.attributeList?[index]
                                      .attributeNameController?.text ??
                                  "");
                          debugPrint(
                              "My attribute name : ${provider.attributeList?[index].attributeName}");
                          debugPrint(
                              "My all values are : ${provider.attributeList?[index].values}");
                          provider.attributeList?.forEach(
                            (element) {
                              debugPrint(
                                  'My attributes are : ${element.toJson()}');
                            },
                          );

                          debugPrint('My combination are: ${provider.combos}');
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
        Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.combos.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final combo = provider.combos[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          combo["combination"],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Stock",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  CommonTextField(
                                    labelText: "Stock",
                                    hintText: "Stock",
                                    controller: combo["stock"],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Regular Price",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  CommonTextField(
                                    labelText: "Regular Price",
                                    hintText: "Regular Price",
                                    controller: combo["regular_price"],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discount Price",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  CommonTextField(
                                    labelText: "Discount Price",
                                    hintText: "Discount Price",
                                    controller: combo["discount_price"],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
