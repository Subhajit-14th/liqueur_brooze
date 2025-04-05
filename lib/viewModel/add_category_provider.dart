import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/CategoryControllers/categpry_controller.dart';
import 'package:liqueur_brooze/model/CategoryModels/add_category_api_res_model.dart';
import 'package:liqueur_brooze/model/CategoryModels/category_list_api_res_model.dart';
import 'package:liqueur_brooze/model/CategoryModels/delete_categpry_api_res_model.dart';
import 'package:liqueur_brooze/model/CategoryModels/update_category_api_res_model.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class AddCategoryProvider extends ChangeNotifier {
  final TextEditingController _categoryNameController = TextEditingController();
  TextEditingController get categoryNameController => _categoryNameController;

  final TextEditingController _updateCategoryNameController =
      TextEditingController();
  TextEditingController get updateCategoryNameController =>
      _updateCategoryNameController;

  List<Catagories>? _allCategories = [];
  List<Catagories>? get allCategories => _allCategories;

  CategoryListApiResModel _categoryListApiResModel = CategoryListApiResModel();
  UpdateCategoryApiResModel _updateCategoryApiResModel =
      UpdateCategoryApiResModel();
  DeleteCategoryApiResModel _deleteCategoryApiResModel =
      DeleteCategoryApiResModel();
  AddCategoryApiResModel _addCategoryApiResModel = AddCategoryApiResModel();

  final CategoryController _categoryController = CategoryController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCategoryUpdate = false;
  bool get isCategoryUpdate => _isCategoryUpdate;

  bool _isCategoryUpdateComplete = false;
  bool get isCategoryUpdateComplete => _isCategoryUpdateComplete;

  bool _isAddCategory = false;
  bool get isAddCategory => _isAddCategory;

  /// get category list
  Future<void> getCategoryList(context) async {
    _isLoading = true;
    notifyListeners();
    _categoryListApiResModel =
        await _categoryController.getCategpryList(context: context);
    if (_categoryListApiResModel.success == true) {
      _allCategories = _categoryListApiResModel.catagories;
      _isLoading = false;
    } else {
      _isLoading = false;
    }
    notifyListeners();
  }

  /// update category list
  void updateCategoryList(context, categoryId, updateCategoryname) async {
    _isCategoryUpdate = true;
    notifyListeners();
    _updateCategoryApiResModel = await _categoryController.updateCategory(
        context: context,
        categoryId: categoryId,
        updatedCategoryName: updateCategoryname);
    if (_updateCategoryApiResModel.success == true) {
      getCategoryList(context);
      _isCategoryUpdate = false;
      _isCategoryUpdateComplete = true;
    } else {
      _isCategoryUpdate = false;
    }
    notifyListeners();
  }

  /// delete category
  void deleteCategory(context, categoryId) async {
    _deleteCategoryApiResModel = await _categoryController.deleteCategory(
        context: context, categoryId: categoryId);
    if (_deleteCategoryApiResModel.success == true) {
      getCategoryList(context);
    } else {
      getCategoryList(context);
    }
    notifyListeners();
  }

  /// add category
  void addCategory(context, categoryName) async {
    _isAddCategory = true;
    notifyListeners();
    _addCategoryApiResModel = await _categoryController.addCategory(
        context: context, categoryName: categoryName);
    if (_addCategoryApiResModel.success == true) {
      _isAddCategory = false;
      getCategoryList(context);
      showSnackBar(context, '${_addCategoryApiResModel.message}');
      _categoryNameController.clear();
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
