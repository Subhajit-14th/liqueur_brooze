import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/edit_product_provider.dart';
import 'package:provider/provider.dart';

class EditAttributeScreen extends StatefulWidget {
  const EditAttributeScreen({super.key});

  @override
  State<EditAttributeScreen> createState() => _EditAttributeScreenState();
}

class _EditAttributeScreenState extends State<EditAttributeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (context.watch<EditProductProvider>().editAttributeList ?? []).isEmpty
            ? SizedBox()
            : const Text(
                "Attributes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
        const SizedBox(height: 10),
        Consumer<EditProductProvider>(builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.editAttributeList?.length,
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
                            provider.editAttributeList?[index].attributeName ??
                                "",
                        hintText:
                            provider.editAttributeList?[index].attributeName ??
                                "",
                        controller: provider.editAttributeList?[index]
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
                          provider.addEditValues(
                              index,
                              provider.editAttributeList?[index]
                                      .attributeNameController?.text ??
                                  "");
                          debugPrint(
                              "My attribute name : ${provider.editAttributeList?[index].attributeName}");
                          debugPrint(
                              "My all values are : ${provider.editAttributeList?[index].values}");
                          provider.editAttributeList?.forEach(
                            (element) {
                              debugPrint(
                                  'My attributes are : ${element.toJson()}');
                            },
                          );

                          debugPrint(
                              'My combination are: ${provider.editCombos}');
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
        Consumer<EditProductProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.editCombos.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final combo = provider.editCombos[index];

                // Get attribute part excluding 'other_attributes'
                final attributeText = combo.entries
                    .where((entry) => entry.key != "other_attributes")
                    .map((entry) => "${entry.value}")
                    .join(" - ");

                // Get the controllers
                final controllers = combo["other_attributes"];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attributeText,
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
                                    controller: controllers["stock"],
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
                                    controller: controllers["price"],
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
                                    controller: controllers["discount_price"],
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
