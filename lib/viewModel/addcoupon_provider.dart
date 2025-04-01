import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/CouponControllers/coupon_controller.dart';
import 'package:liqueur_brooze/model/CouponModels/add_coupon_api_res_model.dart';
import 'package:liqueur_brooze/model/CouponModels/all_coupon_list_api_res_model.dart'
    as all_coupon;
import 'package:liqueur_brooze/model/CouponModels/delete_coupon_api_res_model.dart';
import 'package:liqueur_brooze/model/CouponModels/update_coupon_api_res_model.dart';

class AddcouponProvider extends ChangeNotifier {
  final List<String> _couponType = ['Percentage', 'Discount'];
  List<String> get couponType => _couponType;

  String? _selectedCouponType;
  String? get selectedCouponType => _selectedCouponType;

  String? _selectedUpdateCouponType;
  String? get selectedUpdateCouponType => _selectedUpdateCouponType;

  final TextEditingController _couponCodeController = TextEditingController();
  TextEditingController get couponCodeController => _couponCodeController;

  final TextEditingController _updatedCouponCodeController =
      TextEditingController();
  TextEditingController get updatedCouponCodeController =>
      _updatedCouponCodeController;

  final TextEditingController _valueController = TextEditingController();
  TextEditingController get valueController => _valueController;

  final TextEditingController _updateValueController = TextEditingController();
  TextEditingController get updateValueController => _updateValueController;

  final TextEditingController _startDateController = TextEditingController();
  TextEditingController get startDateController => _startDateController;

  final TextEditingController _updatedStartDateController =
      TextEditingController();
  TextEditingController get updatedStartDateController =>
      _updatedStartDateController;

  final TextEditingController _endDateController = TextEditingController();
  TextEditingController get endDateController => _endDateController;

  final TextEditingController _updateEndDateController =
      TextEditingController();
  TextEditingController get updateEndDateController => _updateEndDateController;

  List<all_coupon.Data>? _allCouponData = [];
  List<all_coupon.Data>? get allCouponData => _allCouponData;

  all_coupon.AllCouponApiResModel _allCouponApiResModel =
      all_coupon.AllCouponApiResModel();
  AddCouponApiResModel _addCouponApiResModel = AddCouponApiResModel();
  DeleteCouponApiResModel _deleteCouponApiResModel = DeleteCouponApiResModel();
  UpdateCouponApiResModel _updateCouponApiResModel = UpdateCouponApiResModel();

  final CouponController _couponController = CouponController();

  bool _isCouponLoad = false;
  bool get isCouponLoad => _isCouponLoad;

  bool _isAddCoupon = false;
  bool get isAddCoupon => _isAddCoupon;

  bool _isUpdateCoupon = false;
  bool get isUpdateCoupon => _isUpdateCoupon;

  /// set Coupon Type
  void setCouponType(String couponType) {
    _selectedCouponType = couponType;
    notifyListeners();
  }

  /// set update and edit coupon type
  void setUpdatedCouponType(String updatedCouponType) {
    _selectedUpdateCouponType = updatedCouponType;
    notifyListeners();
  }

  /// Set Start Date
  void setStartDate(String date) {
    startDateController.text = date;
    notifyListeners();
  }

  /// set for update and edit
  void setUpdateStartDate(String date) {
    updatedStartDateController.text = date;
    notifyListeners();
  }

  /// set for update and edit
  void setUpdateEndDate(String date) {
    updateEndDateController.text = date;
    notifyListeners();
  }

  /// set end date
  void setEndDate(String date) {
    endDateController.text = date;
    notifyListeners();
  }

  /// get coupon list
  void getAllCoupon(context) async {
    _isCouponLoad = true;
    notifyListeners();
    _allCouponApiResModel =
        await _couponController.getAllCouponList(context: context);
    if (_allCouponApiResModel.status == 1) {
      _allCouponData?.clear();
      _isCouponLoad = false;
      _allCouponData = _allCouponApiResModel.data;
    } else {
      _isCouponLoad = false;
    }
    notifyListeners();
  }

  /// Add Coupon
  void addCoupon(
      {required BuildContext context,
      required String couponType,
      required String couponCode,
      required int couponValue,
      required String startDate,
      required String endDate}) async {
    _isAddCoupon = true;
    notifyListeners();
    _addCouponApiResModel = await _couponController.addCoupon(
        context: context,
        couponType: couponType,
        couponCode: couponCode,
        couponValue: couponValue,
        startDate: startDate,
        endDate: endDate);
    if (_addCouponApiResModel.status == 1) {
      _isAddCoupon = false;
      getAllCoupon(context);
      showSnackBar(context, '${_addCouponApiResModel.message}');
      _selectedCouponType = null;
      _couponCodeController.clear();
      _valueController.clear();
      _startDateController.clear();
      _endDateController.clear();
    } else {
      _isAddCoupon = false;
    }
    notifyListeners();
  }

  /// delete coupon
  void deleteCoupon(context, couponId) async {
    _deleteCouponApiResModel =
        await _couponController.deleteCoupon(context: context, id: couponId);
    if (_deleteCouponApiResModel.status == 1) {
      getAllCoupon(context);
      showSnackBar(context, '${_deleteCouponApiResModel.message}');
    } else {
      showSnackBar(context, "${_deleteCouponApiResModel.message}");
    }
  }

  /// update coupon
  void updateCoupon(
      {required BuildContext context,
      required String couponId,
      required String couponType,
      required String couponCode,
      required int couponValue,
      required String startDate,
      required String endDate}) async {
    _isUpdateCoupon = true;
    notifyListeners();

    _updateCouponApiResModel = await _couponController.updateCoupon(
        context: context,
        couponId: couponId,
        couponType: couponType,
        couponCode: couponCode,
        couponValue: couponValue,
        startDate: startDate,
        endDate: endDate);
    if (_updateCouponApiResModel.status == 1) {
      _isUpdateCoupon = false;
      getAllCoupon(context);
      showSnackBar(context, '${_updateCouponApiResModel.message}');
      _selectedUpdateCouponType = null;
      _updatedCouponCodeController.clear();
      _updateValueController.clear();
      _updatedStartDateController.clear();
      _updateEndDateController.clear();
    } else {
      _isUpdateCoupon = false;
    }
    notifyListeners();
  }
}
