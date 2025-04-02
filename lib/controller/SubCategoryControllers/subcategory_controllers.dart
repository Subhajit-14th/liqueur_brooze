import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/add_sub_category_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/all_sub_categpry_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/delete_sub_category_api_res_model.dart';
import 'package:liqueur_brooze/model/SubCategoryModel/updated_sub_category_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class SubcategoryControllers {
  final dio = getIt<Dio>();

  /// Get all sub category
  Future<AllSubCategoryApiResModel> getAllSubCategory(
      {required BuildContext context}) async {
    AllSubCategoryApiResModel allSubCategoryApiResModel =
        AllSubCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'sub-category/list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      allSubCategoryApiResModel =
          AllSubCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return allSubCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return allSubCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Get all sub category api error: $e');
    }
    return allSubCategoryApiResModel;
  }

  /// Add Sub Category
  Future<AddSubCategoryApiResModel> addSubCategory(
      {required BuildContext context,
      required String categoryId,
      required String subCategoryName}) async {
    AddSubCategoryApiResModel addSubCategoryApiResModel =
        AddSubCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}',
        'Content-Type': 'application/json'
      };
      var data = json.encode({"category": categoryId, "name": subCategoryName});
      var response = await dio.request(
        'sub-category/create',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      addSubCategoryApiResModel =
          AddSubCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return addSubCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return addSubCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Add Sub Category api error: $e');
    }
    return addSubCategoryApiResModel;
  }

  /// delete sub category
  Future<DeleteSubCategoryApiResModel> deleteSubCategory(
      {required BuildContext context, required String subCategoryId}) async {
    DeleteSubCategoryApiResModel deleteSubCategoryApiResModel =
        DeleteSubCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'sub-category/delete/$subCategoryId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      deleteSubCategoryApiResModel =
          DeleteSubCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return deleteSubCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return deleteSubCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Delete Subcategory api error: $e');
    }
    return deleteSubCategoryApiResModel;
  }

  /// update sub category name
  Future<UpdatedSubCategoryApiResModel> updatedSubCategory(
      {required BuildContext context,
      required String subCategoryId,
      required String categoryId,
      required String subCategoryName}) async {
    UpdatedSubCategoryApiResModel updatedSubCategoryApiResModel =
        UpdatedSubCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var data = json.encode({"category": categoryId, "name": subCategoryName});
      var response = await dio.request(
        'sub-category/update/$subCategoryId',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      updatedSubCategoryApiResModel =
          UpdatedSubCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return updatedSubCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return updatedSubCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Updated sub category api error: $e');
    }
    return updatedSubCategoryApiResModel;
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
