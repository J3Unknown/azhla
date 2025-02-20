class FavoriteProduct {
  int? favouriteId;
  int? id;
  String? name;
  String? description;
  String? title;
  String? price;
  String? oldPrice;
  String? serving;
  String? mainImage;

  FavoriteProduct(
      {
        this.favouriteId,
        this.id,
        this.name,
        this.description,
        this.title,
        this.price,
        this.oldPrice,
        this.serving,
        this.mainImage
      });

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favourite_id'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    title = json['title'];
    price = json['price'];
    oldPrice = json['old_price'];
    serving = json['serving'];
    mainImage = json['main_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favourite_id'] = this.favouriteId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['title'] = this.title;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['serving'] = this.serving;
    data['main_image'] = this.mainImage;
    return data;
  }
}
