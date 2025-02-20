import 'package:azhlha/basket_screen/data/basket_object.dart';

class ReservationsObject {
  int? id;
  String? status;
  String? orderNumber;
  String? updatedAt;
  List<OrderDetails>? orderDetails;
  Seller? seller;

  ReservationsObject(
      {this.id,
        this.status,
        this.orderNumber,
        this.updatedAt,
        this.orderDetails,
        this.seller});

  ReservationsObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    orderNumber = json['order_number'];
    updatedAt = json['updated_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    seller =
    json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['order_number'] = this.orderNumber;
    data['updated_at'] = this.updatedAt;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  String? price;
  String? quantity;
  ExtraService? extraService;
  Product? product;

  OrderDetails(
      {this.id, this.price, this.quantity, this.extraService, this.product});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    //extraService = json['extra_service'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['extra_service'] = this.extraService;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? title;
  String? price;
  String? oldPrice;
  String? mainImage;
  String? serving;

  Product(
      {this.id,
        this.name,
        this.description,
        this.title,
        this.price,
        this.oldPrice,
        this.mainImage,
        this.serving});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    title = json['title'];
    price = json['price'];
    oldPrice = json['old_price'];
    mainImage = json['main_image'];
    serving = json['serving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['title'] = this.title;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['main_image'] = this.mainImage;
    data['serving'] = this.serving;
    return data;
  }
}

class Seller {
  int? id;
  String? name;
  String? imgPath;

  Seller({this.id, this.name, this.imgPath});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img_path'] = this.imgPath;
    return data;
  }
}
