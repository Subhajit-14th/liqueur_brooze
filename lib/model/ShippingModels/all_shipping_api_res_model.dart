class AllShippingApiResModel {
  String? message;
  List<Data>? data;

  AllShippingApiResModel({this.message, this.data});

  AllShippingApiResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
