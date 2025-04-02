import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/AuthControllers/auth_controllers.dart';
import 'package:liqueur_brooze/model/AuthModels/login_model.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailContoller => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  LoginApiResModel _loginApiResModel = LoginApiResModel();
  LoginApiResModel get loginApiResModel => _loginApiResModel;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final AuthControllers _authControllers = AuthControllers();

  AuthProvider() {
    _checkAuthentication();
  }

  /// Public method to check authentication and navigate to login if needed
  void checkAuthAndRedirect() {
    _checkAuthentication();
  }

  /// Check if user is authenticated by checking stored access token
  Future<void> _checkAuthentication() async {
    debugPrint('Check the auth token');
    String? token = HiveDatabase.getAccessToken(); // Fetch token from Hive
    if (token.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  /// login function
  void login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill the phone number and password field",
            style: TextStyle(
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColor.secondaryColor, // Custom background color
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating, // Makes it floating
          margin: EdgeInsets.only(
            bottom: 50, // Adjust bottom spacing
            left: 20,
            right: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          elevation: 10, // Shadow effect
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white, // Color of the action button
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      _isLoading = false;
      notifyListeners();
      return;
    }

    _loginApiResModel = await _authControllers.login(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );

    if (_loginApiResModel.success == true) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${_loginApiResModel.message}",
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
      HiveDatabase.saveAccessToken(accessToken: '${_loginApiResModel.token}');
      _checkAuthentication();
      _isLoading = false;
    } else {
      if (_loginApiResModel.message != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${_loginApiResModel.message}",
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
      }
      _isLoading = false;
    }
    notifyListeners();
  }

  // Optional: Logout function to clear token
  Future<void> logout() async {
    HiveDatabase.clearAllData(); // Clear token
    _isAuthenticated = false;
    notifyListeners(); // Switch back to LoginScreen automatically
  }
}
