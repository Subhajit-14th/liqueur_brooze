import 'package:flutter/material.dart';

class AttributeModel {
  TextEditingController? attributeNameController = TextEditingController();
  String attributeName;
  List<String>? values;

  AttributeModel({
    this.attributeNameController,
    required this.attributeName,
    this.values,
  });

  /// Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      "attributeName": attributeName,
      "values": values ?? [],
    };
  }
}
