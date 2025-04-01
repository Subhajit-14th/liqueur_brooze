class AddCouponApiResModel {
  int? status;
  String? message;
  Data? data;

  AddCouponApiResModel({this.status, this.message, this.data});

  AddCouponApiResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? type;
  String? code;
  int? value;
  String? startingDate;
  String? endingDate;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.type,
      this.code,
      this.value,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    code = json['code'];
    value = json['value'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['code'] = code;
    data['value'] = value;
    data['starting_date'] = startingDate;
    data['ending_date'] = endingDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
