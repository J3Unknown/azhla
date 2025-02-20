class HomeObject {
  List<Categories>? categories;
  List<Sliders>? sliders;

  HomeObject({this.categories, this.sliders});

  HomeObject.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;
  int? endPoint;
  List<Children>? children;

  Categories({this.id, this.name, this.image, this.endPoint, this.children});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    endPoint = json['end_point'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['end_point'] = this.endPoint;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  int? parentId;
  String? image;
  List<Sellers>? sellers;

  Children({this.id, this.name, this.parentId, this.sellers,this.image});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    image = json['image'];
    if (json['sellers'] != null) {
      sellers = <Sellers>[];
      json['sellers'].forEach((v) {
        sellers!.add(new Sellers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    if (this.sellers != null) {
      data['sellers'] = this.sellers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sellers {
  int? id;
  String? name;
  double? longitude;
  double? latitude;
  String? details;
  String? imgPath;
  Pivot? pivot;

  Sellers(
      {this.id,
        this.name,
        this.longitude,
        this.latitude,
        this.details,
        this.imgPath,
        this.pivot});

  Sellers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    details = json['details'];
    imgPath = json['img_path'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['details'] = this.details;
    data['img_path'] = this.imgPath;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? categoryId;
  int? sellerId;

  Pivot({this.categoryId, this.sellerId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    sellerId = json['seller_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['seller_id'] = this.sellerId;
    return data;
  }
}

class Sliders {
  int? id;
  String? name;
  String? link;

  Sliders({this.id, this.name, this.link});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}
