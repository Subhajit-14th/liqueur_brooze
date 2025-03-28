class CategoryListApiResModel {
  bool? success;
  List<Catagories>? catagories;

  CategoryListApiResModel({this.success, this.catagories});

  CategoryListApiResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['catagories'] != null) {
      catagories = <Catagories>[];
      json['catagories'].forEach((v) {
        catagories!.add(Catagories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (catagories != null) {
      data['catagories'] = catagories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Catagories {
  String? sId;
  String? catagoryname;
  String? createdAt;
  int? iV;

  Catagories({this.sId, this.catagoryname, this.createdAt, this.iV});

  Catagories.fromJson(Map<String, dynamic> json) {
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
