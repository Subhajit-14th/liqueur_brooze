import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/ShippingControllers/shipping_controllers.dart';
import 'package:liqueur_brooze/model/ShippingModels/add_shipping_api_res_model.dart';
import 'package:liqueur_brooze/model/ShippingModels/all_shipping_api_res_model.dart'
    as all_shipping;
import 'package:liqueur_brooze/model/ShippingModels/delete_shipping_api_res_model.dart';
import 'package:liqueur_brooze/model/ShippingModels/update_shipping_api_res_model.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class ShippingChargesProvider extends ChangeNotifier {
  final TextEditingController _pinCodeController = TextEditingController();
  TextEditingController get pinCodeController => _pinCodeController;

  final TextEditingController _updatePinCodeController =
      TextEditingController();
  TextEditingController get updatePinCodeController => _updatePinCodeController;

  final TextEditingController _shippingController = TextEditingController();
  TextEditingController get shippingController => _shippingController;

  final TextEditingController _updateShippingController =
      TextEditingController();
  TextEditingController get updateShippingController =>
      _updateShippingController;

  all_shipping.AllShippingApiResModel _allShippingApiResModel =
      all_shipping.AllShippingApiResModel();
  List<all_shipping.Data>? _allShipping = [];
  List<all_shipping.Data>? get allShipping => _allShipping;

  AddShippingApiResModel _addShippingApiResModel = AddShippingApiResModel();
  DeleteShippingApiResModel _deleteShippingApiResModel =
      DeleteShippingApiResModel();
  UpdateShippingApiResModel _updateShippingApiResModel =
      UpdateShippingApiResModel();

  final ShippingControllers _shippingControllers = ShippingControllers();

  bool _isPageLoad = false;
  bool get isPageLoad => _isPageLoad;

  bool _isAddShipping = false;
  bool get isAddShipping => _isAddShipping;

  bool _isUpdateShipping = false;
  bool get isUpdateShipping => _isUpdateShipping;

  /// get all shipping charge
  void getAllShippingCharge(context) async {
    _isPageLoad = true;
    notifyListeners();
    _allShippingApiResModel =
        await _shippingControllers.getAllShippingCharge(context: context);
    if (_allShippingApiResModel.message ==
        "Shipping list fetched successfully") {
      _allShipping?.clear();
      _isPageLoad = false;
      _allShipping = _allShippingApiResModel.data;
    } else {
      _isPageLoad = false;
    }
    notifyListeners();
  }

  /// add shipping charge
  void addShippingCharge(context, pincode, shippingAmount) async {
    _isAddShipping = true;
    notifyListeners();
    _addShippingApiResModel = await _shippingControllers.addShippingCharge(
        context: context, pinCode: pincode, shippingAmount: shippingAmount);

    if (_addShippingApiResModel.message ==
        'Shipping details added successfully') {
      _isAddShipping = false;
      getAllShippingCharge(context);
      _pinCodeController.clear();
      _shippingController.clear();
      showSnackBar(context, "${_addShippingApiResModel.message}");
    } else {
      _isAddShipping = false;
    }
    notifyListeners();
  }

  /// delete shipping charge
  void deleteShippingCharge(context, shippingChargeId) async {
    _deleteShippingApiResModel =
        await _shippingControllers.deleteShippingCharge(
            context: context, shippingChargeId: shippingChargeId);
    if (_deleteShippingApiResModel.message ==
        "Shipping details deleted successfully") {
      getAllShippingCharge(context);
    } else {
      getAllShippingCharge(context);
    }
    notifyListeners();
  }

  /// updated shipping charge
  void updateShippingCharge(
      context, shippingChargeId, newPincode, newShippingAmount) async {
    _isUpdateShipping = true;
    notifyListeners();
    _updateShippingApiResModel =
        await _shippingControllers.updateShippingCharge(
            context: context,
            shippingChargeId: shippingChargeId,
            newPincode: newPincode,
            newShippingAmount: newShippingAmount);
    if (_updateShippingApiResModel.message ==
        "Shipping details updated successfully") {
      _isUpdateShipping = false;
      getAllShippingCharge(context);
      _updatePinCodeController.clear();
      _updateShippingController.clear();
      showSnackBar(context, "${_updateShippingApiResModel.message}");
    } else {
      _isUpdateShipping = false;
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
