import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/CouponModels/add_coupon_api_res_model.dart';
import 'package:liqueur_brooze/model/CouponModels/all_coupon_list_api_res_model.dart';
import 'package:liqueur_brooze/model/CouponModels/delete_coupon_api_res_model.dart';
import 'package:liqueur_brooze/model/CouponModels/update_coupon_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class CouponController {
  final dio = getIt<Dio>();

  /// get all coupon list
  Future<AllCouponApiResModel> getAllCouponList(
      {required BuildContext context}) async {
    AllCouponApiResModel allCouponApiResModel = AllCouponApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'coupon/list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      allCouponApiResModel = AllCouponApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return allCouponApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return allCouponApiResModel;
      }
    } catch (e) {
      debugPrint('Get all coupons api error: $e');
    }
    return allCouponApiResModel;
  }

  /// add coupon data
  Future<AddCouponApiResModel> addCoupon(
      {required BuildContext context,
      required String couponType,
      required String couponCode,
      required int couponValue,
      required String startDate,
      required String endDate}) async {
    AddCouponApiResModel addCouponApiResModel = AddCouponApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "type": couponType,
        "code": couponCode,
        "value": couponValue,
        "starting_date": startDate,
        "ending_date": endDate
      });
      var response = await dio.request(
        'coupon/create',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      addCouponApiResModel = AddCouponApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return addCouponApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return addCouponApiResModel;
      }
    } catch (e) {
      debugPrint('Add Coupon Api Res Model: $e');
    }
    return addCouponApiResModel;
  }

  /// delete coupon data
  Future<DeleteCouponApiResModel> deleteCoupon(
      {required BuildContext context, required String id}) async {
    DeleteCouponApiResModel deleteCouponApiResModel = DeleteCouponApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var response = await dio.request(
        'coupon/delete/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      deleteCouponApiResModel = DeleteCouponApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return deleteCouponApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return deleteCouponApiResModel;
      }
    } catch (e) {
      debugPrint('Delete api res error: $e');
    }
    return deleteCouponApiResModel;
  }

  /// update coupon data
  Future<UpdateCouponApiResModel> updateCoupon(
      {required BuildContext context,
      required String couponId,
      required String couponType,
      required String couponCode,
      required int couponValue,
      required String startDate,
      required String endDate}) async {
    UpdateCouponApiResModel updateCouponApiResModel = UpdateCouponApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "type": couponType,
        "code": couponCode,
        "value": couponValue,
        "starting_date": startDate,
        "ending_date": endDate
      });
      var response = await dio.request(
        'coupon/update/$couponId',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      updateCouponApiResModel = UpdateCouponApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return updateCouponApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return updateCouponApiResModel;
      }
    } catch (e) {
      debugPrint('update coupon api res model: $e');
    }
    return updateCouponApiResModel;
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
