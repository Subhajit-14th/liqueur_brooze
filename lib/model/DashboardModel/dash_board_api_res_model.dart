class DashboardApiResModel {
  int? status;
  String? message;
  Data? data;

  DashboardApiResModel({this.status, this.message, this.data});

  DashboardApiResModel.fromJson(Map<String, dynamic> json) {
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
  String? duration;
  Sales? sales;
  Sales? revenue;
  Sales? totalCustomers;

  Data({this.duration, this.sales, this.revenue, this.totalCustomers});

  Data.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    sales = json['sales'] != null ? Sales.fromJson(json['sales']) : null;
    revenue = json['revenue'] != null ? Sales.fromJson(json['revenue']) : null;
    totalCustomers = json['total_customers'] != null
        ? Sales.fromJson(json['total_customers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    if (sales != null) {
      data['sales'] = sales!.toJson();
    }
    if (revenue != null) {
      data['revenue'] = revenue!.toJson();
    }
    if (totalCustomers != null) {
      data['total_customers'] = totalCustomers!.toJson();
    }
    return data;
  }
}

class Sales {
  String? amount;
  String? percentage;
  String? isIncrease;

  Sales({this.amount, this.percentage, this.isIncrease});

  Sales.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    percentage = json['percentage'];
    isIncrease = json['is_increase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['percentage'] = percentage;
    data['is_increase'] = isIncrease;
    return data;
  }
}
