class EditProductApiResModel {
  bool? success;
  String? message;
  Product? product;

  EditProductApiResModel({this.success, this.message, this.product});

  EditProductApiResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  String? category;
  String? subCategory;
  String? sku;
  String? variation;
  String? regulerPrice;
  String? discountPrice;
  String? stock;
  List<Attributes>? attributes;
  String? description;

  Product(
      {this.sId,
      this.productName,
      this.category,
      this.subCategory,
      this.sku,
      this.variation,
      this.regulerPrice,
      this.discountPrice,
      this.stock,
      this.attributes,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['product_name'];
    category = json['category'];
    subCategory = json['sub_category'];
    sku = json['sku'];
    variation = json['variation'];
    regulerPrice = json['reguler_price'];
    discountPrice = json['discount_price'];
    stock = json['stock'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    description = json['description'];
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
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    return data;
  }
}

class Attributes {
  String? size;
  String? color;
  OtherAttributes? otherAttributes;

  Attributes({this.size, this.color, this.otherAttributes});

  Attributes.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    color = json['color'];
    otherAttributes = json['other_attributes'] != null
        ? OtherAttributes.fromJson(json['other_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['color'] = color;
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
