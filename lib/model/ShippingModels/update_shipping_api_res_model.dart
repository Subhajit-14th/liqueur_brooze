class UpdateShippingApiResModel {
  String? message;
  Data? data;

  UpdateShippingApiResModel({this.message, this.data});

  UpdateShippingApiResModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? pincode;
  String? shippingAmount;
  String? createdAt;
  int? iV;

  Data({this.sId, this.pincode, this.shippingAmount, this.createdAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pincode = json['Pincode'];
    shippingAmount = json['Shipping_Amount'];
    createdAt = json['CreatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['Pincode'] = pincode;
    data['Shipping_Amount'] = shippingAmount;
    data['CreatedAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
