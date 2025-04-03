import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:liqueur_brooze/viewModel/product_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddCategoryProvider>(context, listen: false)
          .getCategoryList(context);
      Provider.of<AddSubCategoryProvider>(context, listen: false)
          .getAllSubCategory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Product",
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      controller: productProvider.productNameController,
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
                            .read<ProductProvider>()
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
                              ?.firstWhere(
                                  (category) => category.catagoryname == value);
                          if (selectedCategory != null) {
                            context
                                .read<ProductProvider>()
                                .setCategoryValueAndId(
                                  selectedCategory.catagoryname!,
                                  selectedCategory.sId!,
                                );

                            /// Filter subcategories based on the selected category
                            context.read<ProductProvider>().filterSubCategories(
                                  selectedCategory.sId!,
                                  context
                                          .read<AddSubCategoryProvider>()
                                          .allSubCategory ??
                                      [],
                                );

                            // Reset subcategory selection
                            context.read<ProductProvider>().resetSubCategory();
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
                            .read<ProductProvider>()
                            .selectedAddSubCategoryValue,
                        hint: const Text("Choose a sub category"),
                        items: context
                            .read<ProductProvider>()
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
                                .read<ProductProvider>()
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
                      controller: productProvider.skuIdController,
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
                        value: context.read<ProductProvider>().productVariation,
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
                              .read<ProductProvider>()
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
                    if (context.watch<ProductProvider>().productVariation ==
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
                        controller: productProvider.regularPriceController,
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
                        controller: productProvider.discountPriceController,
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
                        controller: productProvider.stockController,
                      ),
                      SizedBox(height: height * 0.02),
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
                          productProvider.pickImage();
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
                              productProvider.productImageName,
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
                    productProvider.selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(productProvider.selectedImage!))
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
                          productProvider.pickProductGalleryImages();
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
                              productProvider
                                      .selectedProductGalleryImages.isNotEmpty
                                  ? '${productProvider.selectedProductGalleryImages.length} Images Selected'
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
                    Consumer<ProductProvider>(
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
                                      borderRadius: BorderRadius.circular(10),
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
                        controller: productProvider.quillController,
                      ),
                    ),

                    /// Text Editor
                    quill.QuillSimpleToolbar(
                      controller: productProvider.quillController,
                      config: const quill.QuillSimpleToolbarConfig(),
                    ),
                    SizedBox(height: height * 0.02),

                    /// Add Buttons
                    CommonButton(
                      width: double.infinity,
                      buttonText: 'Add',
                      buttonColor: AppColor.primaryColor,
                      buttonTextFontSize: 16,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
