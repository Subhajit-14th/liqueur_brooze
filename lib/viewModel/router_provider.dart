import 'package:flutter/material.dart';

class RouterProvider extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  final List<String> _pageHeading = [
    'Dashboard',
    'Pages',
    'Category',
    'Sub Category',
    'Product',
    'User',
    'Coupon',
    'Shipping Charge',
    'Default Charge',
    'Settings',
  ];

  List<String> get pageHeading => _pageHeading;

  /// set the page index
  void setPageIndex(index) {
    _pageIndex = index;
    notifyListeners();
  }
}
