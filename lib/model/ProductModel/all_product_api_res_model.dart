class AllProductApiResModel {
  bool? success;
  String? message;
  List<Products>? products;

  AllProductApiResModel({this.success, this.message, this.products});

  AllProductApiResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
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
  List<Attributes>? attributes;
  String? description;
  String? productImage;
  List<String>? galleryImages;
  String? createdAt;
  String? updatedAt;
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
      this.attributes,
      this.description,
      this.productImage,
      this.galleryImages,
      this.createdAt,
      this.updatedAt,
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
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    description = json['description'];
    productImage = json['productImage'];
    galleryImages = json['galleryImages'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['productImage'] = productImage;
    data['galleryImages'] = galleryImages;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Attributes {
  String? att1;
  String? att2;
  OtherAttributes? otherAttributes;

  Attributes({this.att1, this.att2, this.otherAttributes});

  Attributes.fromJson(Map<String, dynamic> json) {
    att1 = json['att1'];
    att2 = json['att 2'];
    otherAttributes = json['other_attributes'] != null
        ? new OtherAttributes.fromJson(json['other_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['att1'] = att1;
    data['att 2'] = att2;
    if (otherAttributes != null) {
      data['other_attributes'] = otherAttributes!.toJson();
    }
    return data;
  }
}

class OtherAttributes {
  int? price;
  int? discountPrice;
  int? stock;

  OtherAttributes({this.price, this.discountPrice, this.stock});

  OtherAttributes.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    discountPrice = json['discount_price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['stock'] = stock;
    return data;
  }
}
