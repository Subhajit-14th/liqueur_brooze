class AddShippingApiResModel {
  String? message;
  Data? data;

  AddShippingApiResModel({this.message, this.data});

  AddShippingApiResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? pincode;
  String? shippingAmount;
  String? sId;
  String? createdAt;
  int? iV;

  Data({this.pincode, this.shippingAmount, this.sId, this.createdAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    pincode = json['Pincode'];
    shippingAmount = json['Shipping_Amount'];
    sId = json['_id'];
    createdAt = json['CreatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Pincode'] = pincode;
    data['Shipping_Amount'] = shippingAmount;
    data['_id'] = sId;
    data['CreatedAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
