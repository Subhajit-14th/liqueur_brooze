import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/PagesModel/all_pages_api_res_model.dart';
import 'package:liqueur_brooze/model/PagesModel/crreate_page_api_res_model.dart';
import 'package:liqueur_brooze/model/PagesModel/delete_pages_api_res_model.dart';
import 'package:liqueur_brooze/model/PagesModel/update_page_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class PagesControllers {
  final dio = getIt<Dio>();

  /// get all pages list
  Future<AllPagesApiResModel> getAllPages(
      {required BuildContext context}) async {
    AllPagesApiResModel allPagesApiResModel = AllPagesApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'page/list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      allPagesApiResModel = AllPagesApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return allPagesApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return allPagesApiResModel;
      }
    } catch (e) {
      debugPrint('All Pages Api Error: $e');
    }
    return allPagesApiResModel;
  }

  /// add pages create
  Future<CreatePagesApiResModel> createPages(
      {required BuildContext context,
      required String title,
      required String description}) async {
    CreatePagesApiResModel createPagesApiResModel = CreatePagesApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var data = json.encode({"title": title, "description": description});
      var response = await dio.request(
        'page/create',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      createPagesApiResModel = CreatePagesApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return createPagesApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return createPagesApiResModel;
      }
    } catch (e) {
      debugPrint('Create pages api error: $e');
    }
    return createPagesApiResModel;
  }

  /// Delete pages
  Future<DeletePagesApiResModel> deletePages(
      {required BuildContext context, required String pagesId}) async {
    DeletePagesApiResModel deletePagesApiResModel = DeletePagesApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'page/delete/$pagesId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      deletePagesApiResModel = DeletePagesApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return deletePagesApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return deletePagesApiResModel;
      }
    } catch (e) {
      debugPrint('delete api res model: $e');
    }
    return deletePagesApiResModel;
  }

  /// update pages category
  Future<UpdatePagesApiResModel> updatePages(
      {required BuildContext context,
      required String pagesId,
      required String title,
      required String description}) async {
    UpdatePagesApiResModel updatePagesApiResModel = UpdatePagesApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var data = json.encode({"title": title, "description": description});
      var response = await dio.request(
        'page/update/$pagesId',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      updatePagesApiResModel = UpdatePagesApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return updatePagesApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return updatePagesApiResModel;
      }
    } catch (e) {
      debugPrint('Update pages api error: $e');
    }
    return updatePagesApiResModel;
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
