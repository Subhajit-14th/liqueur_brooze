import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liqueur_brooze/controller/ProductControllers/product_controller.dart';
import 'package:liqueur_brooze/model/ProductModel/all_product_api_res_model.dart'
    as allproduct;
import 'package:liqueur_brooze/model/SubCategoryModel/all_sub_categpry_api_res_model.dart'
    as allSubCategory;
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ProductProvider extends ChangeNotifier {
  final TextEditingController _productNameController = TextEditingController();
  TextEditingController get productNameController => _productNameController;

  /// for update product
  final TextEditingController _updateProductNameController =
      TextEditingController();
  TextEditingController get updateProductNameController =>
      _updateProductNameController;

  String? _selectedCategoryValue;
  String? get selectedCategoryValue => _selectedCategoryValue;

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  /// for update product
  String? _selectedUpdatedCategoryValue;
  String? get selectedUpdatedCategoryValue => _selectedUpdatedCategoryValue;

  /// for update product
  String? _selectedUpdatedCategoryId;
  String? get selectedUpdatedCategoryId => _selectedUpdatedCategoryId;

  String? _selectedAddSubCategoryValue;
  String? get selectedAddSubCategoryValue => _selectedAddSubCategoryValue;

  String? _selectedSubCategoryId;
  String? get selectedSubCategoryId => _selectedSubCategoryId;

  /// for update product
  String? _selectedUpdatedSubCategoryValue;
  String? get selectedUpdatedSubCategoryValue =>
      _selectedUpdatedSubCategoryValue;

  /// for update product
  String? _selectedUpdatedSubCategoryId;
  String? get selectedUpdatedSubCategoryId => _selectedUpdatedSubCategoryId;

  List<allSubCategory.Data>? _filteredSubCategory = [];
  List<allSubCategory.Data>? get filteredSubCategory => _filteredSubCategory;

  final TextEditingController _skuIdController = TextEditingController();
  TextEditingController get skuIdController => _skuIdController;

  /// for update product
  final TextEditingController _updatedskuIdController = TextEditingController();
  TextEditingController get updatedskuIdController => _updatedskuIdController;

  String? _productVariation = "Simple";
  String? get productVariation => _productVariation;

  /// for update product
  String? _updatedProductVariation;
  String? get updatedProductVariation => _updatedProductVariation;

  final TextEditingController _regularPriceController = TextEditingController();
  TextEditingController get regularPriceController => _regularPriceController;

  /// for update product
  final TextEditingController _updatedRegularPriceController =
      TextEditingController();
  TextEditingController get updatedRegularPriceController =>
      _updatedRegularPriceController;

  final TextEditingController _discountPriceController =
      TextEditingController();
  TextEditingController get discountPriceController => _discountPriceController;

  /// for update product
  final TextEditingController _updatedDiscountPriceController =
      TextEditingController();
  TextEditingController get updatedDiscountPriceController =>
      _updatedDiscountPriceController;

  final TextEditingController _stockController = TextEditingController();
  TextEditingController get stockController => _stockController;

  /// for update product
  final TextEditingController _updatedStockController = TextEditingController();
  TextEditingController get updatedStockController => _updatedStockController;

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

  /// for update product
  File? _selectedUpdatedProductImage;
  String _updatedProductImageName = "Choose File";

  File? get selectedImage => _selectedProductImage;
  String get productImageName => _productImageName;

  /// for update product
  File? get selectedUpdatedProductImage => _selectedUpdatedProductImage;
  String get updatedProductImageName => _updatedProductImageName;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedProductImage = File(pickedFile.path);
      _productImageName = pickedFile.name;
      notifyListeners();
    }
  }

  /// for update product
  Future<void> updatepickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedUpdatedProductImage = File(pickedFile.path);
      _updatedProductImageName = pickedFile.name;
      notifyListeners();
    }
  }

  List<File> _selectedProductGalleryImages = [];
  List<File> get selectedProductGalleryImages => _selectedProductGalleryImages;

  /// for update product
  List<File> _selectedUpdateProductGalleryImages = [];
  List<File> get selectedUpdateProductGalleryImages =>
      _selectedUpdateProductGalleryImages;

  Future<void> pickProductGalleryImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(); // Allow multiple images

    if (pickedFiles.isNotEmpty) {
      _selectedProductGalleryImages =
          pickedFiles.map((file) => File(file.path)).toList();
      notifyListeners();
    }
  }

  /// for update product
  Future<void> pickUpdateProductGalleryImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(); // Allow multiple images

    if (pickedFiles.isNotEmpty) {
      _selectedUpdateProductGalleryImages =
          pickedFiles.map((file) => File(file.path)).toList();
      notifyListeners();
    }
  }

  // Function to remove a selected image
  void removeImage(int index) {
    _selectedProductGalleryImages.removeAt(index);
    notifyListeners();
  }

  /// for update product
  void removeUpdateImage(int index) {
    _selectedUpdateProductGalleryImages.removeAt(index);
    notifyListeners();
  }

  final quill.QuillController _quillController = quill.QuillController.basic();
  quill.QuillController get quillController => _quillController;

  /// for update product
  final quill.QuillController _updateQuillController =
      quill.QuillController.basic();
  quill.QuillController get updateQuillController => _updateQuillController;

  bool _isProductLoad = false;
  bool get isProductLoad => _isProductLoad;

  allproduct.AllProductApiResModel _allProductApiResModel =
      allproduct.AllProductApiResModel();
  List<allproduct.Products>? _allProducts = [];
  List<allproduct.Products>? get allProducts => _allProducts;

  final ProductController _productApiControllers = ProductController();

  /// get all products
  void getAllProducts(context) async {
    _isProductLoad = true;
    notifyListeners();
    _allProductApiResModel =
        await _productApiControllers.getAllShippingCharge(context: context);
    if (_allProductApiResModel.success == true) {
      _allProducts?.clear();
      _isProductLoad = false;
      _allProducts = _allProductApiResModel.products;
    } else {
      _isProductLoad = false;
    }
    notifyListeners();
  }
}
