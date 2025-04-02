import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/DashboardModel/dash_board_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class DashboardControllers {
  final dio = getIt<Dio>();
  Future<DashboardApiResModel> getDashBoardData(
      {required BuildContext context}) async {
    DashboardApiResModel dashboardApiResModel = DashboardApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'dashboard',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );
      dashboardApiResModel = DashboardApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return dashboardApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return dashboardApiResModel;
      }
    } catch (e) {
      debugPrint('Dashboard api error: $e');
    }
    return dashboardApiResModel;
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
