class BasketObject {
  int? id;
  String? totalPrice;
  String? status;
  String? orderNumber;
  String? updatedAt;
  List<OrderDetails>? orderDetails;

  BasketObject(
      {this.id,
        this.totalPrice,
        this.status,
        this.orderNumber,
        this.updatedAt,
        this.orderDetails});

  BasketObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['total_price'];
    status = json['status'];
    orderNumber = json['order_number'];
    updatedAt = json['updated_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['order_number'] = this.orderNumber;
    data['updated_at'] = this.updatedAt;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  String? price;
  String? quantity;
  Product? product;
  ExtraService? extraService;

  OrderDetails(
      {this.id, this.price, this.quantity, this.product, this.extraService});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    extraService = json['extra_service'] != null
        ? new ExtraService.fromJson(json['extra_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.extraService != null) {
      data['extra_service'] = this.extraService!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? description;
  String? title;
  String? name;
  String? mainImage;

  Product({this.id, this.description, this.title, this.name, this.mainImage});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    title = json['title'];
    name = json['name'];
    mainImage = json['main_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['title'] = this.title;
    data['name'] = this.name;
    data['main_image'] = this.mainImage;
    return data;
  }
}

class ExtraService {
  int? id;
  int? orderDetailsId;
  int? extraServiceId;
  String? price;
  ExtraDetails? extraDetails;

  ExtraService(
      {this.id,
        this.orderDetailsId,
        this.extraServiceId,
        this.price,
        this.extraDetails});

  ExtraService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDetailsId = json['order_details_id'];
    extraServiceId = json['extra_service_id'];
    price = json['price'];
    extraDetails = json['extra_details'] != null
        ? new ExtraDetails.fromJson(json['extra_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_details_id'] = this.orderDetailsId;
    data['extra_service_id'] = this.extraServiceId;
    data['price'] = this.price;
    if (this.extraDetails != null) {
      data['extra_details'] = this.extraDetails!.toJson();
    }
    return data;
  }
}

class ExtraDetails {
  int? id;
  String? description;

  ExtraDetails({this.id, this.description});

  ExtraDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}
