import 'package:flutter/material.dart';

class AddCategoryProvider extends ChangeNotifier {
  final TextEditingController _categoryController = TextEditingController();
  TextEditingController get categoryController => _categoryController;
}
