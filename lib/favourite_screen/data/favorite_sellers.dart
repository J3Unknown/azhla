class FavoriteSeller {
  int? id;
  String? name;
  double? longitude;
  double? latitude;
  String? details;
  String? imgPath;

  FavoriteSeller(
      {this.id,
        this.name,
        this.longitude,
        this.latitude,
        this.details,
        this.imgPath});

  FavoriteSeller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    details = json['details'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['details'] = this.details;
    data['img_path'] = this.imgPath;
    return data;
  }
}
