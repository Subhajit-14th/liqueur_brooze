import 'package:flutter/material.dart';

class AddSubCategoryProvider extends ChangeNotifier {
  final List<String> _addSubCategoryValue = [
    'Option One',
    'Option Two',
    'Option Three',
    'Option Three'
  ];

  List<String> get addSubCategoryValue => _addSubCategoryValue;

  String? _selectedAddSubCategoryValue;
  String? get selectedAddSubCategoryValue => _selectedAddSubCategoryValue;

  final TextEditingController _subCategoryController = TextEditingController();
  TextEditingController get subCategoryController => _subCategoryController;

  /// set sub category value
  void setSubCategory(String subCategoryValue) {
    _selectedAddSubCategoryValue = subCategoryValue;
    notifyListeners();
  }
}
