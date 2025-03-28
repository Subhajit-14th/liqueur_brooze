import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/CategoryControllers/categpry_controller.dart';
import 'package:liqueur_brooze/model/CategoryModels/category_list_api_res_model.dart';

class AddCategoryProvider extends ChangeNotifier {
  final TextEditingController _categoryNameController = TextEditingController();
  TextEditingController get categoryNameController => _categoryNameController;

  List<Catagories>? _allCategories = [];
  List<Catagories>? get allCategories => _allCategories;

  CategoryListApiResModel _categoryListApiResModel = CategoryListApiResModel();

  final CategoryController _categoryController = CategoryController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getCategoryList(context) async {
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
}
