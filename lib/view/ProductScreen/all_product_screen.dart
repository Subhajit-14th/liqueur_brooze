import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/ProductScreen/add_product_screen.dart';
import 'package:liqueur_brooze/view/ProductScreen/edit_product_screen.dart';
import 'package:liqueur_brooze/viewModel/product_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .getAllProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Product",
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
          /// Heading items and add pages buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Product',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monserat',
                  ),
                ),
                CommonButton(
                  width: 130,
                  height: 40,
                  buttonText: 'Add Product',
                  buttonTextFontSize: 12,
                  buttonColor: AppColor.primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductScreen()));
                  },
                ),
              ],
            ),
          ),

          /// Product list
          Consumer<ProductProvider>(builder: (context, provider, child) {
            if (provider.isProductLoad) {
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
                itemCount: provider.allProducts?.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(14),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            provider.allProducts?[index].productImage ?? '',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://static.thenounproject.com/png/509537-200.png',
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),

                        /// Product Name & Regular Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Name",
                                    style: TextStyle(
                                      color: Colors.black.withAlpha(180),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    provider.allProducts?[index].productName ??
                                        '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Regular Price",
                                  style: TextStyle(
                                    color: Colors.black.withAlpha(180),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                                Text(
                                  "£ ${provider.allProducts?[index].regulerPrice}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserat',
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        /// SKU & Discount Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SKU",
                                    style: TextStyle(
                                      color: Colors.black.withAlpha(180),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    provider.allProducts?[index].sku ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Discount Price",
                                  style: TextStyle(
                                    color: Colors.black.withAlpha(180),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                                Text(
                                  "£ ${provider.allProducts?[index].discountPrice}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserat',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        /// Variation
                        Text(
                          "Variation",
                          style: TextStyle(
                            color: Colors.black.withAlpha(180),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        Text(
                          provider.allProducts?[index].variation ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserat',
                          ),
                        ),
                        SizedBox(height: 10),

                        /// Buttons (View, Edit, Delete)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle View Action
                                  showProductDetailsDialog(
                                      context, provider.allProducts?[index]);
                                  debugPrint(
                                      "${provider.allProducts?[index].attributes}");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle Edit Action
                                  debugPrint("💬 On Tap");
                                  debugPrint(
                                      'My attributre values are: ${provider.allProducts?[index].attributes?.first.toJson()}');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProductScreen(
                                                productId:
                                                    "${provider.allProducts?[index].sId}",
                                                editProductName:
                                                    "${provider.allProducts?[index].productName}",
                                                editProductCategoryId:
                                                    "${provider.allProducts?[index].category}",
                                                editProductSubCategoryId:
                                                    "${provider.allProducts?[index].subCategory}",
                                                editProductSKUId:
                                                    "${provider.allProducts?[index].sku}",
                                                editProductVariation:
                                                    "${provider.allProducts?[index].variation}",
                                                editProductRegulerPriceField:
                                                    "${provider.allProducts?[index].regulerPrice}",
                                                editProductDiscountPriceField:
                                                    "${provider.allProducts?[index].discountPrice}",
                                                editProductStockField:
                                                    "${provider.allProducts?[index].stock}",
                                                editProductDescription:
                                                    "${provider.allProducts?[index].description}",
                                                editProductImageUrl:
                                                    "${provider.allProducts?[index].productImage}",
                                                editProductGalleryUrls: provider
                                                        .allProducts?[index]
                                                        .galleryImages ??
                                                    [],
                                                attributes: provider
                                                        .allProducts?[index]
                                                        .attributes ??
                                                    [],
                                              )));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle Delete Action
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Delete Product"),
                                        content: Text(
                                            "Are you sure you want to delete this product?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .deleteProduct(context,
                                                      "${provider.allProducts?[index].sId}");
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
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

  void showProductDetailsDialog(BuildContext context, dynamic product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // Set a fixed width
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // Ensures it wraps content properly
                children: [
                  /// Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.productImage ?? '',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://static.thenounproject.com/png/509537-200.png',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  /// Product Name
                  Text(
                    "Product Name: ${product.productName}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  /// SKU
                  Text(
                    "SKU: ${product.sku}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),

                  /// Regular Price
                  Text(
                    "Regular Price: £ ${product.regulerPrice}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                  /// Discount Price
                  Text(
                    "Discount Price: £ ${product.discountPrice}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  /// Variation
                  Text(
                    "Variation: ${product.variation}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),

                  /// Attributes Table
                  Text(
                    "Attributes:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  Table(
                    border: TableBorder.all(color: Colors.black, width: 1),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                    },
                    children: [
                      /// Table Header
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Att 1",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Att 2",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Price",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Discount",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Stock",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),

                      /// Table Rows (Dynamic)
                      ...product.attributes.map<TableRow>((attr) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(attr.att1 ?? ''),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(attr.att2 ?? ''),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  attr.otherAttributes?.price.toString() ?? ''),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(attr.otherAttributes?.discountPrice
                                      .toString() ??
                                  ''),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  attr.otherAttributes?.stock.toString() ?? ''),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 16),

                  /// Description
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Html(
                    data: product.description ?? "", // Render HTML content
                    style: {
                      "body": Style(fontSize: FontSize.medium),
                      "p": Style(color: Colors.black87),
                      "strong": Style(fontWeight: FontWeight.bold),
                    },
                  ),

                  /// Close Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
