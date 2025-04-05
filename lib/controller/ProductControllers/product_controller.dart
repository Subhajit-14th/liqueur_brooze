import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/model/ProductModel/add_product_api_res_model.dart';
import 'package:liqueur_brooze/model/ProductModel/all_product_api_res_model.dart';
import 'package:liqueur_brooze/model/ProductModel/delete_product_api_res_model.dart';
import 'package:liqueur_brooze/model/ProductModel/update_product_model_api_res_model.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:liqueur_brooze/viewModel/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductController {
  final dio = getIt<Dio>();

  /// get all product
  Future<AllProductApiResModel> getAllProducts(
      {required BuildContext context}) async {
    AllProductApiResModel allProductApiResModel = AllProductApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.request(
        'productlist',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      allProductApiResModel = AllProductApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return allProductApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return allProductApiResModel;
      }
    } catch (e) {
      debugPrint('Get All product api error: $e');
    }
    return allProductApiResModel;
  }

  /// add product
  Future<AddProductApiResModel> addProduct({
    required BuildContext context,
    required String productName,
    required String category,
    required String subCategory,
    required String sku,
    required String variation,
    required String regulerPrice,
    required String discountPrice,
    required String stock,
    required attributes,
    required String description,
    required String productImage,
    required List<String> galleryImages,
  }) async {
    AddProductApiResModel addProductApiResModel = AddProductApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://api.booze247.co.uk/api/addproduct'));
      request.fields.addAll({
        'product_name': productName,
        'category': category,
        'sub_category': subCategory,
        'sku': sku,
        'variation': variation,
        'reguler_price': regulerPrice,
        'discount_price': discountPrice,
        'stock': stock,
        'attributes': jsonEncode(attributes),
        'description': description,
      });

      String extension = productImage.split('.').last.toLowerCase();
      MediaType mediaType;

      if (extension == 'png') {
        mediaType = MediaType('image', 'png');
      } else {
        mediaType = MediaType('image', 'jpeg');
      }

      request.files.add(await http.MultipartFile.fromPath(
          'productImage', productImage,
          contentType: mediaType));

      for (String path in galleryImages) {
        String extension = path.split('.').last.toLowerCase();
        MediaType mediaType;

        if (extension == 'png') {
          mediaType = MediaType('image', 'png');
        } else {
          mediaType = MediaType('image', 'jpeg');
        }
        request.files.add(
          await http.MultipartFile.fromPath('galleryImages', path,
              contentType: mediaType),
        );
      }

      request.headers.addAll(headers);

      debugPrint('Step 6 : $attributes');
      debugPrint('Request Fields: ${request.fields}');
      debugPrint('Files: ${request.files}');

      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.toBytes();
      String responseString = String.fromCharCodes(responseData);

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Raw Response: $responseString');

      try {
        var result = jsonDecode(responseString);
        addProductApiResModel = AddProductApiResModel.fromJson(result);
      } catch (e) {
        if (context.mounted) {
          context.read<ProductProvider>().setProductAdd(false);
        }
        debugPrint("JSON decode failed: $e");
      }
    } on PlatformException catch (e) {
      if (!context.mounted) return addProductApiResModel;
      context.read<ProductProvider>().setProductAdd(false);
      showSnackBar(context, "Platform Error $e");
    } catch (e) {
      if (context.mounted) {
        context.read<ProductProvider>().setProductAdd(false);
      }
      debugPrint('Add Product api error: $e');
    }
    return addProductApiResModel;
  }

  /// delete product
  Future<DeleteProductApiResModel> deleteProduct(
      {required BuildContext context, required String productId}) async {
    DeleteProductApiResModel deleteProductApiResModel =
        DeleteProductApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var response = await dio.delete(
        'deleteproduct/$productId',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      deleteProductApiResModel =
          DeleteProductApiResModel.fromJson(response.data);
    } on PlatformException catch (e) {
      if (!context.mounted) return deleteProductApiResModel;
      showSnackBar(context, "Platform Error $e");
    } on DioException catch (e) {
      debugPrint('Step 6 : $e');
      // Handle 400 error
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        if (context.mounted) {
          context.read<AuthProvider>().logout();
        }
        return deleteProductApiResModel;
      }
    } catch (e) {
      debugPrint('Delete Product api error: $e');
    }
    return deleteProductApiResModel;
  }

  /// edit product
  Future<EditProductApiResModel> editProduct({
    required BuildContext context,
    required String productId,
    required String productName,
    required String category,
    required String subCategory,
    required String sku,
    required String variation,
    required String regulerPrice,
    required String discountPrice,
    required String stock,
    required attributes,
    required String description,
    required String productImage,
    required List<String> galleryImages,
  }) async {
    EditProductApiResModel editProductApiResModel = EditProductApiResModel();
    try {
      var headers = {
        'Authorization': 'Bearer ${HiveDatabase.getAccessToken()}'
      };
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
          'https://api.booze247.co.uk/api/updateproduct/$productId',
        ),
      );
      request.fields.addAll({
        'product_name': productName,
        'category': category,
        'sub_category': subCategory,
        'sku': sku,
        'variation': variation,
        'reguler_price': regulerPrice,
        'discount_price': discountPrice,
        'stock': stock,
        'attributes': jsonEncode(attributes),
        'description': description,
      });

      String extension = productImage.split('.').last.toLowerCase();
      MediaType mediaType;

      if (extension == 'png') {
        mediaType = MediaType('image', 'png');
      } else {
        mediaType = MediaType('image', 'jpeg');
      }

      request.files.add(await http.MultipartFile.fromPath(
          'productImage', productImage,
          contentType: mediaType));

      for (String path in galleryImages) {
        String extension = path.split('.').last.toLowerCase();
        MediaType mediaType;

        if (extension == 'png') {
          mediaType = MediaType('image', 'png');
        } else {
          mediaType = MediaType('image', 'jpeg');
        }
        request.files.add(
          await http.MultipartFile.fromPath('galleryImages', path,
              contentType: mediaType),
        );
      }

      request.headers.addAll(headers);

      debugPrint('Step 6 : $attributes');
      debugPrint('Request Fields: ${request.fields}');
      debugPrint('Files: ${request.files}');

      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.toBytes();
      String responseString = String.fromCharCodes(responseData);

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Raw Response: $responseString');

      try {
        var result = jsonDecode(responseString);
        editProductApiResModel = EditProductApiResModel.fromJson(result);
      } catch (e) {
        if (context.mounted) {
          context.read<ProductProvider>().setProductAdd(false);
        }
        debugPrint("JSON decode failed: $e");
      }
    } on PlatformException catch (e) {
      if (!context.mounted) return editProductApiResModel;
      context.read<ProductProvider>().setProductAdd(false);
      showSnackBar(context, "Platform Error $e");
    } catch (e) {
      if (context.mounted) {
        context.read<ProductProvider>().setProductAdd(false);
      }
      debugPrint('Add Product api error: $e');
    }
    return editProductApiResModel;
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
