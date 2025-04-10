class UpdatedSubCategoryApiResModel {
  int? status;
  String? message;
  Data? data;

  UpdatedSubCategoryApiResModel({this.status, this.message, this.data});

  UpdatedSubCategoryApiResModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  Category? category;
  int? createdAt;
  int? updatedAt;

  Data({this.sId, this.name, this.category, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Category {
  String? sId;
  String? catagoryname;
  String? createdAt;
  int? iV;

  Category({this.sId, this.catagoryname, this.createdAt, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    catagoryname = json['catagoryname'];
    createdAt = json['CreatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['catagoryname'] = catagoryname;
    data['CreatedAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
