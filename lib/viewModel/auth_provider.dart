import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailContoller => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;
}
