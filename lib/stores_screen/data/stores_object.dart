class StoresObject {
  int? id;
  String? name;
  String? description;
  String? price;
  String? oldPrice;
  String? mainImage;
  String? serving;
  String? title;

  StoresObject({
    this.id,
    this.name,
    this.description,
    this.price,
    this.oldPrice,
    this.mainImage,
    this.serving,
    this.title
  });

  StoresObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    mainImage = json['main_image'];
    serving = json['serving'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['main_image'] = this.mainImage;
    data['serving'] = this.serving;
    data['title'] = this.title;
    return data;
  }
}
