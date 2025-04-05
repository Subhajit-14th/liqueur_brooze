import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liqueur_brooze/controller/ProductControllers/product_controller.dart';
import 'package:liqueur_brooze/model/ProductModel/all_combination_model.dart';
import 'package:liqueur_brooze/model/ProductModel/attribute_model.dart';
import 'package:liqueur_brooze/model/ProductModel/update_product_model_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/all_sub_categpry_api_res_model.dart'
    as allSubCategory;
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/product_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:liqueur_brooze/model/ProductModel/all_product_api_res_model.dart'
    as allproduct;
import 'package:provider/provider.dart';

class EditProductProvider extends ChangeNotifier {
  final TextEditingController _productNameController = TextEditingController();
  TextEditingController get productNameController => _productNameController;

  String? _selectedCategoryValue;
  String? get selectedCategoryValue => _selectedCategoryValue;

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  String? _selectedAddSubCategoryValue;
  String? get selectedAddSubCategoryValue => _selectedAddSubCategoryValue;

  String? _selectedSubCategoryId;
  String? get selectedSubCategoryId => _selectedSubCategoryId;

  List<allSubCategory.Data>? _filteredSubCategory = [];
  List<allSubCategory.Data>? get filteredSubCategory => _filteredSubCategory;

  /// set category value and id
  void setCategoryValueAndId(categoryValue, categoryId) {
    _selectedCategoryValue = categoryValue;
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  /// set sub category value and id
  void setSubCategoryValueAndId(subCategoryValue, subCategoryId) {
    _selectedAddSubCategoryValue = subCategoryValue;
    _selectedSubCategoryId = subCategoryId;
    notifyListeners();
  }

  /// filtered data
  void filterSubCategories(
      String categoryId, List<allSubCategory.Data> allSubCategories) {
    _filteredSubCategory = allSubCategories
        .where((subCategory) => subCategory.category?.sId == categoryId)
        .toList();
    notifyListeners();
  }

  /// reset sub category
  void resetSubCategory() {
    _selectedAddSubCategoryValue = null;
    notifyListeners();
  }

  /// SKU ID
  final TextEditingController _skuIdController = TextEditingController();
  TextEditingController get skuIdController => _skuIdController;

  /// prodict variation
  String? _productVariation = "Simple";
  String? get productVariation => _productVariation;

  /// selected product variation
  void selectedProductVariation(productVariation) {
    _productVariation = productVariation;
    notifyListeners();
  }

  final TextEditingController _regularPriceController = TextEditingController();
  TextEditingController get regularPriceController => _regularPriceController;

  final TextEditingController _discountPriceController =
      TextEditingController();
  TextEditingController get discountPriceController => _discountPriceController;

  final TextEditingController _stockController = TextEditingController();
  TextEditingController get stockController => _stockController;

  /// Image selection for product image
  File? _selectedProductImage;
  String _productImageName = "Choose File";

  File? get selectedImage => _selectedProductImage;
  String get productImageName => _productImageName;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedProductImage = File(pickedFile.path);
      _productImageName = pickedFile.name;
      notifyListeners();
    }
  }

  Future<void> setExistingProductImageUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/product_image.jpg';

        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        _selectedProductImage = file;
        _productImageName = file.path.split('/').last;

        notifyListeners();
      } else {
        print('Failed to download image from URL');
      }
    } catch (e) {
      print('Error while downloading image: $e');
    }
  }

  List<File> _selectedProductGalleryImages = [];
  List<File> get selectedProductGalleryImages => _selectedProductGalleryImages;

  Future<void> pickProductGalleryImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(); // Allow multiple images

    if (pickedFiles.isNotEmpty) {
      _selectedProductGalleryImages =
          pickedFiles.map((file) => File(file.path)).toList();
      notifyListeners();
    }
  }

  Future<void> setExistingProductGalleryUrls(List<String> urls) async {
    try {
      final tempDir = await getTemporaryDirectory();
      List<File> downloadedImages = [];

      for (int i = 0; i < urls.length; i++) {
        final response = await http.get(Uri.parse(urls[i]));

        if (response.statusCode == 200) {
          final filePath = '${tempDir.path}/gallery_image_$i.jpg';
          File file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
          downloadedImages.add(file);
        } else {
          print('Failed to download image at index $i');
        }
      }

      _selectedProductGalleryImages = downloadedImages;
      notifyListeners();
    } catch (e) {
      print('Error downloading gallery images: $e');
    }
  }

  // Function to remove a selected image
  void removeImage(int index) {
    _selectedProductGalleryImages.removeAt(index);
    notifyListeners();
  }

  final quill.QuillController _quillController = quill.QuillController.basic();
  quill.QuillController get quillController => _quillController;

  bool _isEditProductAdd = false;
  bool get isEditProductAdd => _isEditProductAdd;

  EditProductApiResModel _editProductApiResModel = EditProductApiResModel();
  final ProductController _productApiControllers = ProductController();

  /// for dispose values
  void resetAllFields() {
    _productNameController.clear();
    _skuIdController.clear();
    _regularPriceController.clear();
    _discountPriceController.clear();
    _stockController.clear();
    _selectedCategoryValue = null;
    _selectedCategoryId = null;
    _selectedAddSubCategoryValue = null;
    _selectedSubCategoryId = null;
    _filteredSubCategory = [];
    _selectedProductImage = null;
    _productImageName = "Choose File";
    _selectedProductGalleryImages = [];
    _productVariation = "Simple";
    _quillController.document = quill.Document();
    notifyListeners();
  }

  final TextEditingController _editAttributeNameController =
      TextEditingController();
  TextEditingController get editAttributeNameController =>
      _editAttributeNameController;
  List<AttributeModel> _editAttributeList = [];
  List<AttributeModel>? get editAttributeList => _editAttributeList;

  List<Map<String, dynamic>> _editCombos = [];
  List<Map<String, dynamic>> get editCombos => _editCombos;

  List<VariationCombination> _editVariations = [];
  List<VariationCombination> get editVariations => _editVariations;

  /// add attribute
  void addEditProductAttribute() {
    _editAttributeList.add(AttributeModel(
      attributeName: _editAttributeNameController.text,
      attributeNameController: TextEditingController(),
      values: [],
    ));
    _editAttributeNameController.clear();
    notifyListeners();
  }

  /// void add values for perticuler values
  void addEditValues(int index, String value) {
    _editAttributeList[index].values?.add(value);
    _editAttributeList[index].attributeNameController?.clear();
    generateCombinations(_editAttributeList);
    notifyListeners();
  }

  /// Function to generate dynamic attribute combinations
  void generateCombinations(List<AttributeModel> attributes) {
    List<List<String>> valueLists =
        attributes.map((attr) => List<String>.from(attr.values ?? [])).toList();

    List<String> attributeNames =
        attributes.map((attr) => attr.attributeName).toList();

    if (valueLists.length == 1 || valueLists[1].isEmpty) {
      _editCombos = valueLists.first.map((value) {
        Map<String, dynamic> comboMap = {};
        comboMap[attributeNames.first] = value;
        comboMap["other_attributes"] = {
          "stock": TextEditingController(text: "0"),
          "price": TextEditingController(text: "0"),
          "discount_price": TextEditingController(text: "0"),
        };
        return comboMap;
      }).toList();
      notifyListeners();
      return;
    }

    List<List<String>> cartesianProduct(List<List<String>> lists,
        [int depth = 0, List<String>? current = const []]) {
      if (depth == lists.length) return [current!];
      return lists[depth]
          .expand((value) =>
              cartesianProduct(lists, depth + 1, [...current!, value]))
          .toList();
    }

    _editCombos = cartesianProduct(valueLists).map((combination) {
      Map<String, dynamic> comboMap = {};

      for (int i = 0; i < combination.length; i++) {
        comboMap[attributeNames[i]] = combination[i];
      }

      comboMap["other_attributes"] = {
        "stock": TextEditingController(text: "0"),
        "price": TextEditingController(text: "0"),
        "discount_price": TextEditingController(text: "0"),
      };

      return comboMap;
    }).toList();

    notifyListeners();
  }

  List<Map<String, dynamic>> getFormattedCombinations() {
    return _editCombos.map((combo) {
      final other =
          combo["other_attributes"] as Map<String, TextEditingController>;
      final cleaned = {
        for (var entry in combo.entries)
          if (entry.key != "other_attributes") entry.key: entry.value,
        "other_attributes": {
          "stock": int.tryParse(other["stock"]!.text) ?? 0,
          "price": int.tryParse(other["price"]!.text) ?? 0,
          "discount_price": int.tryParse(other["discount_price"]!.text) ?? 0,
        }
      };
      return cleaned;
    }).toList();
  }

  void setEditCombinationsFromModel(List<allproduct.Attributes> attributes) {
    debugPrint("Step: Hit this function");
    if (attributes.isEmpty) {
      _editCombos = [];
      notifyListeners();
      return;
    }
    _editCombos = attributes.map((attr) {
      return {
        if (attr.att1 != null) "att1": attr.att1,
        if (attr.att2 != null) "att2": attr.att2,
        "other_attributes": {
          "stock": TextEditingController(
              text: attr.otherAttributes?.stock?.toString() ?? "0"),
          "price": TextEditingController(
              text: attr.otherAttributes?.price?.toString() ?? "0"),
          "discount_price": TextEditingController(
              text: attr.otherAttributes?.discountPrice?.toString() ?? "0"),
        }
      };
    }).toList();

    notifyListeners();
  }

  /// add product
  void editProduct(context, productId) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    _isEditProductAdd = true;
    notifyListeners();
    _editProductApiResModel = await _productApiControllers.editProduct(
        context: context,
        productId: productId,
        productName: _productNameController.text,
        category: _selectedCategoryId ?? "",
        subCategory: _selectedSubCategoryId ?? "",
        sku: _skuIdController.text,
        variation: _productVariation ?? "Simple",
        regulerPrice: _regularPriceController.text,
        discountPrice: _discountPriceController.text,
        stock: _stockController.text,
        attributes: getFormattedCombinations(),
        description: quillController.document.toPlainText(),
        productImage: _selectedProductImage?.path ?? "",
        galleryImages:
            _selectedProductGalleryImages.map((e) => e.path).toList());
    if (_editProductApiResModel.success == true) {
      _isEditProductAdd = false;
      productProvider.getAllProducts(context);
      _productNameController.clear();
      _selectedCategoryId = null;
      _selectedCategoryValue = null;
      _selectedAddSubCategoryValue = null;
      _selectedSubCategoryId = null;
      _skuIdController.clear();
      _regularPriceController.clear();
      _discountPriceController.clear();
      _stockController.clear();
      _productVariation = "Simple";
      _selectedProductImage = null;
      _productImageName = "Choose File";
      _selectedProductGalleryImages.clear();
      _editAttributeList.clear();
      _editAttributeNameController.clear();
      _editCombos.clear();
      _editVariations.clear();
      _quillController.clear();
      _quillController.document = quill.Document();
      _filteredSubCategory?.clear();
      showSnackBar(context, '${_editProductApiResModel.message}');
    } else {
      _isEditProductAdd = false;
      debugPrint('Step 6 : ${_editProductApiResModel.message}');
    }
    notifyListeners();
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColor.secondaryColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 50,
        left: 20,
        right: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 10,
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
