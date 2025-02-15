import 'package:flutter/material.dart';

class AddcouponProvider extends ChangeNotifier {
  final List<String> _couponType = ['Percentage', 'Discount'];
  List<String> get couponType => _couponType;

  String? _selectedCouponType;
  String? get selectedCouponType => _selectedCouponType;

  final TextEditingController _couponCodeController = TextEditingController();
  TextEditingController get couponCodeController => _couponCodeController;

  final TextEditingController _valueController = TextEditingController();
  TextEditingController get valueController => _valueController;

  final TextEditingController _startDateController = TextEditingController();
  TextEditingController get startDateController => _startDateController;

  final TextEditingController _endDateController = TextEditingController();
  TextEditingController get endDateController => _endDateController;

  /// set Coupon Type
  void setCouponType(String couponType) {
    _selectedCouponType = couponType;
    notifyListeners();
  }

  /// Set Start Date
  void setStartDate(String date) {
    startDateController.text = date;
    notifyListeners();
  }

  /// set end date
  void setEndDate(String date) {
    endDateController.text = date;
    notifyListeners();
  }
}
