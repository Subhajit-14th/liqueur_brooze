import 'package:flutter/material.dart';

class ShippingChargesProvider extends ChangeNotifier {
  final TextEditingController _pinCodeController = TextEditingController();
  TextEditingController get pinCodeController => _pinCodeController;
}
