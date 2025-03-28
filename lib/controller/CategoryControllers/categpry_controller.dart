import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/CategoryModels/category_list_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

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
      if (!context.mounted) return categoryListApiResModel;
      debugPrint("Dio Exception: $e");
      showSnackBar(context, "Dio Exception: $e");
    } catch (e) {
      debugPrint('Category list api error: $e');
    }
    return categoryListApiResModel;
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
