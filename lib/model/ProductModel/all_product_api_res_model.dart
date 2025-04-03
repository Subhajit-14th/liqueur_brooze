class AllProductApiResModel {
  bool? success;
  List<Products>? products;

  AllProductApiResModel({this.success, this.products});

  AllProductApiResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? productName;
  String? category;
  String? subCategory;
  String? sku;
  String? variation;
  int? regulerPrice;
  int? discountPrice;
  int? stock;
  String? description;
  String? productImage;
  List<String>? galleryImages;
  String? createdAt;
  int? iV;

  Products(
      {this.sId,
      this.productName,
      this.category,
      this.subCategory,
      this.sku,
      this.variation,
      this.regulerPrice,
      this.discountPrice,
      this.stock,
      this.description,
      this.productImage,
      this.galleryImages,
      this.createdAt,
      this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['product_name'];
    category = json['category'];
    subCategory = json['sub_category'];
    sku = json['sku'];
    variation = json['variation'];
    regulerPrice = json['reguler_price'];
    discountPrice = json['discount_price'];
    stock = json['stock'];
    description = json['description'];
    productImage = json['productImage'];
    galleryImages = json['galleryImages'].cast<String>();
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product_name'] = productName;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['sku'] = sku;
    data['variation'] = variation;
    data['reguler_price'] = regulerPrice;
    data['discount_price'] = discountPrice;
    data['stock'] = stock;
    data['description'] = description;
    data['productImage'] = productImage;
    data['galleryImages'] = galleryImages;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
