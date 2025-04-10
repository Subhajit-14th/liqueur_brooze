import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liqueur_brooze/controller/ProductControllers/product_controller.dart';
import 'package:liqueur_brooze/model/ProductModel/add_product_api_res_model.dart';
import 'package:liqueur_brooze/model/ProductModel/all_combination_model.dart';
import 'package:liqueur_brooze/model/ProductModel/all_product_api_res_model.dart'
    as allproduct;
import 'package:liqueur_brooze/model/ProductModel/attribute_model.dart';
import 'package:liqueur_brooze/model/ProductModel/delete_product_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/all_sub_categpry_api_res_model.dart'
    as allSubCategory;
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class ProductProvider extends ChangeNotifier {
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

  final TextEditingController _skuIdController = TextEditingController();
  TextEditingController get skuIdController => _skuIdController;

  String? _productVariation = "Simple";
  String? get productVariation => _productVariation;

  final TextEditingController _regularPriceController = TextEditingController();
  TextEditingController get regularPriceController => _regularPriceController;

  final TextEditingController _discountPriceController =
      TextEditingController();
  TextEditingController get discountPriceController => _discountPriceController;

  final TextEditingController _stockController = TextEditingController();
  TextEditingController get stockController => _stockController;

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

  /// selected product variation
  void selectedProductVariation(productVariation) {
    _productVariation = productVariation;
    notifyListeners();
  }

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

  // Function to remove a selected image
  void removeImage(int index) {
    _selectedProductGalleryImages.removeAt(index);
    notifyListeners();
  }

  final quill.QuillController _quillController = quill.QuillController.basic();
  quill.QuillController get quillController => _quillController;

  bool _isProductLoad = false;
  bool get isProductLoad => _isProductLoad;

  bool _isProductAdd = false;
  bool get isProductAdd => _isProductAdd;

  void setProductAdd(bool value) {
    _isProductAdd = value;
    notifyListeners();
  }

  allproduct.AllProductApiResModel _allProductApiResModel =
      allproduct.AllProductApiResModel();
  List<allproduct.Products>? _allProducts = [];
  List<allproduct.Products>? get allProducts => _allProducts;

  AddProductApiResModel _addProductApiResModel = AddProductApiResModel();
  DeleteProductApiResModel _deleteProductApiResModel =
      DeleteProductApiResModel();

  final ProductController _productApiControllers = ProductController();

  final TextEditingController _attributeNameController =
      TextEditingController();
  TextEditingController get attributeNameController => _attributeNameController;
  List<AttributeModel> _attributeList = [];
  List<AttributeModel>? get attributeList => _attributeList;

  List<Map<String, dynamic>> _combos = [];
  List<Map<String, dynamic>> get combos => _combos;

  List<VariationCombination> _variations = [];
  List<VariationCombination> get variations => _variations;

  /// get all products
  void getAllProducts(context) async {
    _isProductLoad = true;
    notifyListeners();
    _allProductApiResModel =
        await _productApiControllers.getAllProducts(context: context);
    if (_allProductApiResModel.success == true) {
      _allProducts?.clear();
      _isProductLoad = false;
      _allProducts = _allProductApiResModel.products;
    } else {
      _isProductLoad = false;
    }
    notifyListeners();
  }

  /// add product
  void addProduct(context) async {
    _isProductAdd = true;
    notifyListeners();
    _addProductApiResModel = await _productApiControllers.addProduct(
        context: context,
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
    if (_addProductApiResModel.success == true) {
      _isProductAdd = false;
      getAllProducts(context);
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
      _attributeList.clear();
      _attributeNameController.clear();
      _combos.clear();
      _variations.clear();
      _quillController.clear();
      _quillController.document = quill.Document();
      _filteredSubCategory?.clear();
      showSnackBar(context, '${_addProductApiResModel.message}');
    } else {
      _isProductAdd = false;
      debugPrint('Step 6 : ${_addProductApiResModel.message}');
    }
    notifyListeners();
  }

  /// add attribute
  void addAttribute() {
    _attributeList.add(AttributeModel(
      attributeName: _attributeNameController.text,
      attributeNameController: TextEditingController(),
      values: [],
    ));
    _attributeNameController.clear();
    notifyListeners();
  }

  /// delete product
  void deleteProduct(context, String productId) async {
    _isProductLoad = true;
    notifyListeners();
    _deleteProductApiResModel = await _productApiControllers.deleteProduct(
        context: context, productId: productId);
    if (_deleteProductApiResModel.success == true) {
      _isProductLoad = false;
      getAllProducts(context);
      showSnackBar(context, '${_deleteProductApiResModel.message}');
    } else {
      _isProductLoad = false;
      debugPrint('Step 6 : ${_deleteProductApiResModel.message}');
    }
    notifyListeners();
  }

  /// void add values for perticuler values
  void addValues(int index, String value) {
    _attributeList[index].values?.add(value);
    _attributeList[index].attributeNameController?.clear();
    generateCombinations(_attributeList);
    notifyListeners();
  }

  /// Function to generate dynamic attribute combinations
  void generateCombinations(List<AttributeModel> attributes) {
    List<List<String>> valueLists =
        attributes.map((attr) => List<String>.from(attr.values ?? [])).toList();

    List<String> attributeNames =
        attributes.map((attr) => attr.attributeName).toList();

    if (valueLists.length == 1 || valueLists[1].isEmpty) {
      _combos = valueLists.first.map((value) {
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

    _combos = cartesianProduct(valueLists).map((combination) {
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
    return _combos.map((combo) {
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
