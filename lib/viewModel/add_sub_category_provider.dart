import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/SubCategoryControllers/subcategory_controllers.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/add_sub_category_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/all_sub_categpry_api_res_model.dart'
    as all_subCategory;
import 'package:liqueur_brooze/model/SubCategoryModel/delete_sub_category_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/updated_sub_category_api_res_model.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class AddSubCategoryProvider extends ChangeNotifier {
  String? _selectedAddSubCategoryValue;
  String? get selectedAddSubCategoryValue => _selectedAddSubCategoryValue;

  String? _selectedUpdatedSubCategoryValue;
  String? get selectedUpdatedSubCategoryValue =>
      _selectedUpdatedSubCategoryValue;

  String? _selectedSubCategoryId;
  String? get selectedSubCategoryId => _selectedSubCategoryId;

  String? _selectedUpdatedSubCategoryId;
  String? get selectedUpdatedSubCategoryId => _selectedUpdatedSubCategoryId;

  final TextEditingController _subCategoryController = TextEditingController();
  TextEditingController get subCategoryController => _subCategoryController;

  final TextEditingController _updatedSubCategoryController =
      TextEditingController();
  TextEditingController get updatedSubCategoryController =>
      _updatedSubCategoryController;

  all_subCategory.AllSubCategoryApiResModel _allSubCategoryApiResModel =
      all_subCategory.AllSubCategoryApiResModel();
  List<all_subCategory.Data>? _allSubCategory = [];
  List<all_subCategory.Data>? get allSubCategory => _allSubCategory;

  AddSubCategoryApiResModel _addSubCategoryApiResModel =
      AddSubCategoryApiResModel();
  DeleteSubCategoryApiResModel _deleteSubCategoryApiResModel =
      DeleteSubCategoryApiResModel();
  UpdatedSubCategoryApiResModel _updatedSubCategoryApiResModel =
      UpdatedSubCategoryApiResModel();

  final SubcategoryControllers _subcategoryApiControllers =
      SubcategoryControllers();

  bool _isSubCategoryLoad = false;
  bool get isSubCategoryLoad => _isSubCategoryLoad;

  bool _isSubCategoryAdd = false;
  bool get isSubCategoryAdd => _isSubCategoryAdd;

  bool _isSubCategoryUpdate = false;
  bool get isSubCategoryUpdate => _isSubCategoryUpdate;

  /// set sub category value
  void setSubCategory(String subCategoryValue, String subCategoryId) {
    _selectedAddSubCategoryValue = subCategoryValue;
    _selectedSubCategoryId = subCategoryId;
    notifyListeners();
  }

  /// set updated category value
  void setUpdatedSubcategory(
      String updatedSubcategoryValue, String updatedSubCategoryId) async {
    _selectedUpdatedSubCategoryValue = updatedSubcategoryValue;
    _selectedUpdatedSubCategoryId = updatedSubCategoryId;
    notifyListeners();
  }

  /// get all sub category
  void getAllSubCategory(context) async {
    _isSubCategoryLoad = true;
    notifyListeners();
    _allSubCategoryApiResModel =
        await _subcategoryApiControllers.getAllSubCategory(context: context);
    if (_allSubCategoryApiResModel.status == 1) {
      _allSubCategory?.clear();
      _isSubCategoryLoad = false;
      _allSubCategory = _allSubCategoryApiResModel.data;
    } else {
      _isSubCategoryLoad = false;
    }
    notifyListeners();
  }

  /// add sub category
  void addSubcategory(context, categoryId, subCategoryName) async {
    _isSubCategoryAdd = true;
    notifyListeners();
    _addSubCategoryApiResModel =
        await _subcategoryApiControllers.addSubCategory(
            context: context,
            categoryId: categoryId,
            subCategoryName: subCategoryName);
    if (_addSubCategoryApiResModel.status == 1) {
      _isSubCategoryAdd = false;
      getAllSubCategory(context);
      _selectedAddSubCategoryValue = null;
      _selectedSubCategoryId = null;
      _subCategoryController.clear();
      showSnackBar(context, "${_addSubCategoryApiResModel.message}");
    } else {
      _isSubCategoryAdd = false;
    }
    notifyListeners();
  }

  /// delete sub category
  void deleteSubCategory(context, subCategoryId) async {
    _deleteSubCategoryApiResModel = await _subcategoryApiControllers
        .deleteSubCategory(context: context, subCategoryId: subCategoryId);
    if (_deleteSubCategoryApiResModel.status == 1) {
      getAllSubCategory(context);
    } else {
      getAllSubCategory(context);
    }
    notifyListeners();
  }

  /// update sub category id
  void updateSubCategory(
      context, subCategoryId, categoryId, subCategoryName) async {
    _isSubCategoryUpdate = true;
    notifyListeners();
    _updatedSubCategoryApiResModel =
        await _subcategoryApiControllers.updatedSubCategory(
            context: context,
            subCategoryId: subCategoryId,
            categoryId: categoryId,
            subCategoryName: subCategoryName);
    if (_updatedSubCategoryApiResModel.status == 1) {
      _isSubCategoryUpdate = false;
      getAllSubCategory(context);
      _selectedUpdatedSubCategoryValue = null;
      _selectedUpdatedSubCategoryId = null;
      _updatedSubCategoryController.clear();
      showSnackBar(context, "${_updatedSubCategoryApiResModel.message}");
    } else {
      _isSubCategoryUpdate = false;
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
