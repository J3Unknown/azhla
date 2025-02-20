class ProductDetails {
  int? id;
  String? name;
  String? description;
  String? price;
  String? mainImage;
  int? picture;
  String? serving;
  List<Images>? images;
  List<ExtraServices>? extraServices;

  ProductDetails(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.mainImage,
        this.picture,
        this.serving,
        this.images,
        this.extraServices});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    mainImage = json['main_image'];
    picture = json['picture'];
    serving = json['serving'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['extra_services'] != null) {
      extraServices = <ExtraServices>[];
      json['extra_services'].forEach((v) {
        extraServices!.add(new ExtraServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['main_image'] = this.mainImage;
    data['picture'] = this.picture;
    data['serving'] = this.serving;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.extraServices != null) {
      data['extra_services'] =
          this.extraServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  int? productId;
  String? name;

  Images({this.id, this.productId, this.name});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    return data;
  }
}

class ExtraServices {
  int? id;
  int? productId;
  String? price;
  String? descriptionAr;
  String? descriptionEn;
  String? createdAt;
  String? updatedAt;

  ExtraServices(
      {this.id,
        this.productId,
        this.price,
        this.descriptionAr,
        this.descriptionEn,
        this.createdAt,
        this.updatedAt});

  ExtraServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class ExtraServicesRequest {
  int? id;


  ExtraServicesRequest({this.id,
  });

  ExtraServicesRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    return data;
  }
}

