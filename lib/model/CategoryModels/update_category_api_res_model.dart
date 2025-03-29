class UpdateCategoryApiResModel {
  bool? success;
  UpdatedCategory? updatedCategory;

  UpdateCategoryApiResModel({this.success, this.updatedCategory});

  UpdateCategoryApiResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    updatedCategory = json['updatedCategory'] != null
        ? UpdatedCategory.fromJson(json['updatedCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (updatedCategory != null) {
      data['updatedCategory'] = updatedCategory!.toJson();
    }
    return data;
  }
}

class UpdatedCategory {
  String? sId;
  String? catagoryname;
  String? createdAt;
  int? iV;

  UpdatedCategory({this.sId, this.catagoryname, this.createdAt, this.iV});

  UpdatedCategory.fromJson(Map<String, dynamic> json) {
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
