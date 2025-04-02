class DeleteSubCategoryApiResModel {
  int? status;
  String? message;

  DeleteSubCategoryApiResModel({this.status, this.message});

  DeleteSubCategoryApiResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
