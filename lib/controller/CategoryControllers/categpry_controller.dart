import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/CategoryModels/add_category_api_res_model.dart';
import 'package:liqueur_brooze/model/CategoryModels/category_list_api_res_model.dart';
import 'package:liqueur_brooze/model/CategoryModels/delete_categpry_api_res_model.dart';
import 'package:liqueur_brooze/model/CategoryModels/update_category_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class CategoryController {
  final dio = getIt<Dio>();

  /// get category list
  Future<CategoryListApiResModel> getCategpryList(
      {required BuildContext context}) async {
    CategoryListApiResModel categoryListApiResModel = CategoryListApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      final response = await dio.request(
        'catagorylist',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      categoryListApiResModel = CategoryListApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return categoryListApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return categoryListApiResModel;
      }
    } catch (e) {
      debugPrint('Category list api error: $e');
    }
    return categoryListApiResModel;
  }

  /// update category section
  Future<UpdateCategoryApiResModel> updateCategory(
      {required BuildContext context,
      required String categoryId,
      required String updatedCategoryName}) async {
    UpdateCategoryApiResModel updateCategoryApiResModel =
        UpdateCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var data = json.encode({"catagoryname": updatedCategoryName});
      final response = await dio.request(
        'updatecatagory/$categoryId',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      updateCategoryApiResModel =
          UpdateCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return updateCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return updateCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Update Categpry Api Error: $e');
    }
    return updateCategoryApiResModel;
  }

  /// Delete category section
  Future<DeleteCategoryApiResModel> deleteCategory(
      {required BuildContext context, required String categoryId}) async {
    DeleteCategoryApiResModel deleteCategoryApiResModel =
        DeleteCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'deletecatagory/$categoryId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      deleteCategoryApiResModel =
          DeleteCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return deleteCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return deleteCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Delete Category Api Error: $e');
    }
    return deleteCategoryApiResModel;
  }

  /// add category
  Future<AddCategoryApiResModel> addCategory(
      {required BuildContext context, required String categoryName}) async {
    AddCategoryApiResModel addCategoryApiResModel = AddCategoryApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var data = json.encode({
        "catagoryname": categoryName,
      });
      var response = await dio.request(
        'addproductcatagory',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      addCategoryApiResModel = AddCategoryApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return addCategoryApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return addCategoryApiResModel;
      }
    } catch (e) {
      debugPrint('Add Category api res model: $e');
    }
    return addCategoryApiResModel;
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
