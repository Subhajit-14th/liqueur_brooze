import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/AuthModels/login_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class AuthControllers {
  final dio = getIt<Dio>();

  Future<LoginApiResModel> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    LoginApiResModel loginApiResModel = LoginApiResModel();
    var data = json.encode({
      "email": email,
      "password": password,
    });
    try {
      final response = await dio.request(
        'adminlogin',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      debugPrint('My response is: ${response.data}');
      loginApiResModel = LoginApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Platform Error $e",
              style: TextStyle(
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColor.secondaryColor,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
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
    } on DioException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Dio Exception: $e",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColor.secondaryColor,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
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
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "My Login Api Error is: $e",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColor.secondaryColor,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
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
    }
    return loginApiResModel;
  }
}
