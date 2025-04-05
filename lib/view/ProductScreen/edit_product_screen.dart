import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/view/ProductScreen/edit_attribute_screen.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:liqueur_brooze/viewModel/edit_product_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:liqueur_brooze/model/ProductModel/all_product_api_res_model.dart'
    as allproduct;

class EditProductScreen extends StatefulWidget {
  const EditProductScreen(
      {super.key,
      required this.editProductName,
      required this.editProductCategoryId,
      required this.editProductSubCategoryId,
      required this.editProductSKUId,
      required this.editProductVariation,
      required this.editProductRegulerPriceField,
      required this.editProductDiscountPriceField,
      required this.editProductStockField,
      required this.editProductDescription,
      required this.editProductImageUrl,
      required this.editProductGalleryUrls,
      required this.attributes,
      required this.productId});

  final String productId;
  final String editProductName;
  final String editProductCategoryId;
  final String editProductSubCategoryId;
  final String editProductSKUId;
  final String editProductVariation;
  final String editProductRegulerPriceField;
  final String editProductDiscountPriceField;
  final String editProductStockField;
  final String editProductDescription;
  final String editProductImageUrl;
  final List<String> editProductGalleryUrls;
  final List<allproduct.Attributes> attributes;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    super.initState();

    debugPrint("📜 This function is hit");

    final provider = Provider.of<EditProductProvider>(context, listen: false);

    provider.productNameController.text = widget.editProductName;
    provider.skuIdController.text = widget.editProductSKUId;
    provider.regularPriceController.text = widget.editProductRegulerPriceField;
    provider.discountPriceController.text =
        widget.editProductDiscountPriceField;
    provider.stockController.text = widget.editProductStockField;
    provider.quillController.document = quill.Document()
      ..insert(0, widget.editProductDescription);
    provider.setExistingProductImageUrl(widget.editProductImageUrl);
    provider.setExistingProductGalleryUrls(widget.editProductGalleryUrls);

    /// 🧠 Delay this part that calls notifyListeners
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider.selectedProductVariation(widget.editProductVariation);

      if (widget.attributes.isNotEmpty) {
        provider.setEditCombinationsFromModel(widget.attributes);
      }

      final categoryProvider =
          Provider.of<AddCategoryProvider>(context, listen: false);
      final subCategoryProvider =
          Provider.of<AddSubCategoryProvider>(context, listen: false);

      await categoryProvider.getCategoryList(context);
      await subCategoryProvider.getAllSubCategory(context);

      // final matchedCategory = categoryProvider.allCategories?.firstWhere(
      //   (cat) => cat.sId == widget.editProductCategoryId,
      // );

      // final matchedSubCategory = subCategoryProvider.allSubCategory?.firstWhere(
      //   (subCat) => subCat.sId == widget.editProductSubCategoryId,
      //   orElse: () => null,
      // );

      dynamic matchedCategory;
      try {
        matchedCategory = categoryProvider.allCategories?.firstWhere(
          (cat) => cat.sId == widget.editProductCategoryId,
        );
      } catch (e) {
        matchedCategory = null;
      }

      dynamic matchedSubCategory;
      try {
        matchedSubCategory = subCategoryProvider.allSubCategory?.firstWhere(
          (subCat) => subCat.sId == widget.editProductSubCategoryId,
        );
      } catch (e) {
        matchedSubCategory = null;
      }

      if (matchedCategory != null) {
        provider.setCategoryValueAndId(
          matchedCategory.catagoryname ?? '',
          matchedCategory.sId ?? '',
        );

        provider.filterSubCategories(
          matchedCategory.sId!,
          subCategoryProvider.allSubCategory ?? [],
        );
      }

      if (matchedSubCategory != null) {
        provider.setSubCategoryValueAndId(
          matchedSubCategory.name,
          matchedSubCategory.sId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final editProductProvider = Provider.of<EditProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Product",
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
      body: context.watch<AddCategoryProvider>().isLoading &&
              context.watch<AddSubCategoryProvider>().isSubCategoryLoad
          ? Center(
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
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Name Field
                        Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        CommonTextField(
                          labelText: 'Enter Title',
                          hintText: 'enter title',
                          controller: editProductProvider.productNameController,
                        ),
                        SizedBox(height: height * 0.02),

                        /// Category Field
                        Text(
                          'Category',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        SizedBox(
                          height: 60, // Increase this height if needed
                          child: DropdownButtonFormField<String>(
                            value: context
                                .read<EditProductProvider>()
                                .selectedCategoryValue,
                            hint: const Text("Choose a category"),
                            items: context
                                .read<AddCategoryProvider>()
                                .allCategories
                                ?.map((category) {
                              return DropdownMenuItem<String>(
                                value: category.catagoryname,
                                child: Text(
                                  category.catagoryname ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              var selectedCategory = context
                                  .read<AddCategoryProvider>()
                                  .allCategories
                                  ?.firstWhere((category) =>
                                      category.catagoryname == value);
                              if (selectedCategory != null) {
                                context
                                    .read<EditProductProvider>()
                                    .setCategoryValueAndId(
                                      selectedCategory.catagoryname!,
                                      selectedCategory.sId!,
                                    );

                                /// Filter subcategories based on the selected category
                                context
                                    .read<EditProductProvider>()
                                    .filterSubCategories(
                                      selectedCategory.sId!,
                                      context
                                              .read<AddSubCategoryProvider>()
                                              .allSubCategory ??
                                          [],
                                    );

                                // Reset subcategory selection
                                context
                                    .read<EditProductProvider>()
                                    .resetSubCategory();
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 14), // Increase vertical padding
                            ),
                            menuMaxHeight: 300, // Increase dropdown height
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        /// Subcategory Field
                        Text(
                          'Sub Category',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        SizedBox(
                          height: 60,
                          child: DropdownButtonFormField<String>(
                            value: context
                                .read<EditProductProvider>()
                                .selectedAddSubCategoryValue,
                            hint: const Text("Choose a sub category"),
                            items: context
                                .read<EditProductProvider>()
                                .filteredSubCategory
                                ?.map((category) {
                              return DropdownMenuItem<String>(
                                value: category.name,
                                child: Text(
                                  category.name ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              var selectedSubCategory = context
                                  .read<AddSubCategoryProvider>()
                                  .allSubCategory
                                  ?.firstWhere(
                                      (category) => category.name == value);
                              if (selectedSubCategory != null) {
                                context
                                    .read<EditProductProvider>()
                                    .setSubCategoryValueAndId(
                                      selectedSubCategory.name,
                                      selectedSubCategory.sId,
                                    );
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 14), // Increase vertical padding
                            ),
                            menuMaxHeight: 300, // Increase dropdown height
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        /// SKU Field
                        Text(
                          'SKU',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        CommonTextField(
                          labelText: 'Enter sku',
                          hintText: 'enter sku',
                          controller: editProductProvider.skuIdController,
                        ),
                        SizedBox(height: height * 0.02),

                        /// Product Variation Field
                        Text(
                          'Product Variation',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        SizedBox(
                          height: 60,
                          child: DropdownButtonFormField<String>(
                            value: context
                                .read<EditProductProvider>()
                                .productVariation,
                            hint: const Text("Choose a sub category"),
                            items: ["Simple", "Variable"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              context
                                  .read<EditProductProvider>()
                                  .selectedProductVariation(value);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 14), // Increase vertical padding
                            ),
                            menuMaxHeight: 300, // Increase dropdown height
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        /// if product variation is simple selected
                        if (context
                                .watch<EditProductProvider>()
                                .productVariation ==
                            "Simple") ...[
                          /// Regular Field
                          Text(
                            'Regular Price',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monserat',
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          CommonTextField(
                            labelText: 'Enter regular price',
                            hintText: 'enter regular price',
                            controller:
                                editProductProvider.regularPriceController,
                          ),
                          SizedBox(height: height * 0.02),

                          /// Discount Field
                          Text(
                            'Discount Price',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monserat',
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          CommonTextField(
                            labelText: 'Enter discount price',
                            hintText: 'enter discount price',
                            controller:
                                editProductProvider.discountPriceController,
                          ),
                          SizedBox(height: height * 0.02),

                          /// Stock Field
                          Text(
                            'Stock',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monserat',
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          CommonTextField(
                            labelText: 'Enter stock',
                            hintText: 'enter stock',
                            controller: editProductProvider.stockController,
                          ),
                          SizedBox(height: height * 0.02),
                        ],

                        if (context
                                .watch<EditProductProvider>()
                                .productVariation ==
                            "Variable") ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Attribute Name
                                    Text(
                                      'Attribute Name',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    CommonTextField(
                                      labelText: 'Enter attribute name',
                                      hintText: 'enter attribute name',
                                      controller: editProductProvider
                                          .editAttributeNameController,
                                    ),
                                    SizedBox(height: height * 0.02),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: CommonButton(
                                  width: 100,
                                  buttonText: 'Add',
                                  buttonColor: AppColor.primaryColor,
                                  buttonTextFontSize: 16,
                                  onTap: () {
                                    if (editProductProvider
                                        .editAttributeNameController
                                        .text
                                        .isNotEmpty) {
                                      editProductProvider
                                          .addEditProductAttribute();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          EditAttributeScreen(),
                        ],

                        /// Product Image
                        Text(
                          'Product Image',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.lightTextColor,
                            border: Border.all(
                              color: AppColor.darkTextColor,
                              strokeAlign: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              editProductProvider.pickImage();
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product Image',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    Text(
                                      'Choose File',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40, // Adjust height as needed
                                  child: VerticalDivider(
                                    color: AppColor.darkTextColor,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  editProductProvider.productImageName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        editProductProvider.selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                    editProductProvider.selectedImage!))
                            : Container(),
                        SizedBox(height: height * 0.02),

                        /// Product Gallery
                        Text(
                          'Product Gallery',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.lightTextColor,
                            border: Border.all(
                              color: AppColor.darkTextColor,
                              strokeAlign: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              editProductProvider.pickProductGalleryImages();
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product Gallery',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    Text(
                                      'Choose File',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40, // Adjust height as needed
                                  child: VerticalDivider(
                                    color: AppColor.darkTextColor,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  editProductProvider
                                          .selectedProductGalleryImages
                                          .isNotEmpty
                                      ? '${editProductProvider.selectedProductGalleryImages.length} Images Selected'
                                      : "Choose Files",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Consumer<EditProductProvider>(
                          builder: (context, value, child) {
                            if (value.selectedProductGalleryImages.isNotEmpty) {
                              return GridView.builder(
                                padding: EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of images per row
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    value.selectedProductGalleryImages.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      // Display Image
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            value.selectedProductGalleryImages[
                                                index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      // Close Button to Remove Image
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            value.removeImage(index);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        SizedBox(height: height * 0.02),

                        /// Description
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: height * 0.01),

                        /// Quill Editor
                        Container(
                          height: 140,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: quill.QuillEditor.basic(
                            controller: editProductProvider.quillController,
                          ),
                        ),

                        /// Text Editor
                        quill.QuillSimpleToolbar(
                          controller: editProductProvider.quillController,
                          config: const quill.QuillSimpleToolbarConfig(),
                        ),
                        SizedBox(height: height * 0.02),

                        /// Add Buttons
                        CommonButton(
                          width: double.infinity,
                          buttonText: 'Update',
                          buttonColor: AppColor.primaryColor,
                          buttonTextFontSize: 16,
                          onTap: () async {
                            if (editProductProvider
                                    .productNameController.text.isNotEmpty &&
                                editProductProvider
                                    .skuIdController.text.isNotEmpty) {
                              editProductProvider.editProduct(
                                  context, widget.productId);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),

                /// Loading Indicator Overlay
                if (context.watch<EditProductProvider>().isEditProductAdd)
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
                          colors: [
                            AppColor.primaryColor,
                            AppColor.secondaryColor
                          ],
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

  @override
  void dispose() {
    Provider.of<EditProductProvider>(context, listen: false).resetAllFields();
    super.dispose();
  }
}
