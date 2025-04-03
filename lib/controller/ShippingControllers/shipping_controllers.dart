import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/ShippingModels/add_shipping_api_res_model.dart';
import 'package:liqueur_brooze/model/ShippingModels/all_shipping_api_res_model.dart';
import 'package:liqueur_brooze/model/ShippingModels/delete_shipping_api_res_model.dart';
import 'package:liqueur_brooze/model/ShippingModels/update_shipping_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class ShippingControllers {
  final dio = getIt<Dio>();

  /// get all shipping charge
  Future<AllShippingApiResModel> getAllShippingCharge(
      {required BuildContext context}) async {
    AllShippingApiResModel allShippingApiResModel = AllShippingApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'shippinglist',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      allShippingApiResModel = AllShippingApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return allShippingApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return allShippingApiResModel;
      }
    } catch (e) {
      debugPrint('Get All Shipping charge api error: $e');
    }
    return allShippingApiResModel;
  }

  /// add category charge
  Future<AddShippingApiResModel> addShippingCharge(
      {required BuildContext context,
      required String pinCode,
      required String shippingAmount}) async {
    AddShippingApiResModel addShippingApiResModel = AddShippingApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var data =
          json.encode({"Pincode": pinCode, "Shipping_Amount": shippingAmount});
      var response = await dio.request(
        'addshipping',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      addShippingApiResModel = AddShippingApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return addShippingApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return addShippingApiResModel;
      }
    } catch (e) {
      debugPrint('Add Shipping charge api error: $e');
    }
    return addShippingApiResModel;
  }

  /// Delete shipping charge
  Future<DeleteShippingApiResModel> deleteShippingCharge(
      {required BuildContext context, required String shippingChargeId}) async {
    DeleteShippingApiResModel deleteShippingApiResModel =
        DeleteShippingApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var response = await dio.request(
        'deleteshipping/$shippingChargeId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      deleteShippingApiResModel =
          DeleteShippingApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return deleteShippingApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return deleteShippingApiResModel;
      }
    } catch (e) {
      debugPrint('Delete shipping charge api error: $e');
    }
    return deleteShippingApiResModel;
  }

  /// update shipping charge
  Future<UpdateShippingApiResModel> updateShippingCharge(
      {required BuildContext context,
      required String shippingChargeId,
      required String newPincode,
      required String newShippingAmount}) async {
    UpdateShippingApiResModel updateShippingApiResModel =
        UpdateShippingApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var data = json.encode(
          {"Pincode": newPincode, "Shipping_Amount": newShippingAmount});
      var response = await dio.request(
        'updateshipping/$shippingChargeId',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      updateShippingApiResModel =
          UpdateShippingApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return updateShippingApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return updateShippingApiResModel;
      }
    } catch (e) {
      debugPrint('Update shipping charge api error: $e');
    }
    return updateShippingApiResModel;
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
