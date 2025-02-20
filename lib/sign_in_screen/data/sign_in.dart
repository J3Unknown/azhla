class Login {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? lang;
  String? token;
  int? type;
  List<Locations>? locations;

  Login(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.lang,
        this.token,
        this.type,
        this.locations});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    lang = json['lang'];
    token = json['token'];
    type = json['type'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['lang'] = this.lang;
    data['token'] = this.token;
    data['type'] = this.type;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  int? id;
  int? userId;
  int? longitude;
  int? latitude;
  String? details;

  Locations(
      {this.id, this.userId, this.longitude, this.latitude, this.details});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['details'] = this.details;
    return data;
  }
}
