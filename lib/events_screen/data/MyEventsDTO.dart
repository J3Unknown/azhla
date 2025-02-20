class MyEventsDTO {
  List<UnderReview>? underReview;
  List<UnderReview>? approved;
  List<UnderReview>? expired;

  MyEventsDTO({this.underReview, this.approved, this.expired});

  MyEventsDTO.fromJson(Map<String, dynamic> json) {
    if (json['underReview'] != null) {
      underReview = <UnderReview>[];
      json['underReview'].forEach((v) {
        underReview!.add(new UnderReview.fromJson(v));
      });
    }
    if (json['approved'] != null) {
      approved = <UnderReview>[];
      json['approved'].forEach((v) {
        approved!.add(new UnderReview.fromJson(v));
      });
    }
    if (json['expired'] != null) {
      expired = <UnderReview>[];
      json['expired'].forEach((v) {
        expired!.add(new UnderReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.underReview != null) {
      data['underReview'] = this.underReview!.map((v) => v.toJson()).toList();
    }
    if (this.approved != null) {
      data['approved'] = this.approved!.map((v) => v.toJson()).toList();
    }
    if (this.expired != null) {
      data['expired'] = this.expired!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnderReview {
  int? id;
  String? name;
  String? description;
  int? eventCategoryId;
  String? phone;
  String? whatsAppNumber;
  String? date;
  String? time;
  String? address;
  String? familyName;
  String? longitude;
  String? latitude;
  String? type;
  String? fPhone;
  String? fWhatsAppNumber;
  String? fAddress;
  String? fLatitude;
  String? fLongitude;
  String? image;
  int? active;
  EventCategory? eventCategory;

  UnderReview(
      {this.id,
        this.name,
        this.description,
        this.eventCategoryId,
        this.phone,
        this.whatsAppNumber,
        this.date,
        this.time,
        this.address,
        this.familyName,
        this.longitude,
        this.latitude,
        this.type,
        this.fPhone,
        this.fWhatsAppNumber,
        this.fAddress,
        this.fLatitude,
        this.fLongitude,
        this.image,
        this.active,
        this.eventCategory});

  UnderReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    eventCategoryId = json['event_category_id'];
    phone = json['phone'];
    whatsAppNumber = json['whatsApp_number'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    familyName = json['family_name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    type = json['type'];
    fPhone = json['f_phone'];
    fWhatsAppNumber = json['f_whatsApp_number'];
    fAddress = json['f_address'];
    fLatitude = json['f_latitude'];
    fLongitude = json['f_longitude'];
    image = json['image'];
    active = json['active'];
    eventCategory = json['event_category'] != null
        ? new EventCategory.fromJson(json['event_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['event_category_id'] = this.eventCategoryId;
    data['phone'] = this.phone;
    data['whatsApp_number'] = this.whatsAppNumber;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['family_name'] = this.familyName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['type'] = this.type;
    data['f_phone'] = this.fPhone;
    data['f_whatsApp_number'] = this.fWhatsAppNumber;
    data['f_address'] = this.fAddress;
    data['f_latitude'] = this.fLatitude;
    data['f_longitude'] = this.fLongitude;
    data['image'] = this.image;
    data['active'] = this.active;
    if (this.eventCategory != null) {
      data['event_category'] = this.eventCategory!.toJson();
    }
    return data;
  }
}

class EventCategory {
  int? id;
  String? name;
  String? image;

  EventCategory({this.id, this.name, this.image});

  EventCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Expired {
  int? id;
  String? name;
  String? description;
  int? eventCategoryId;
  String? phone;
  String? whatsAppNumber;
  String? date;
  String? time;
  String? address;
  String? familyName;
  String? longitude;
  String? latitude;
  String? type;
  Null? fPhone;
  Null? fWhatsAppNumber;
  Null? fAddress;
  Null? fLatitude;
  Null? fLongitude;
  String? image;
  int? active;
  EventCategory? eventCategory;

  Expired(
      {this.id,
        this.name,
        this.description,
        this.eventCategoryId,
        this.phone,
        this.whatsAppNumber,
        this.date,
        this.time,
        this.address,
        this.familyName,
        this.longitude,
        this.latitude,
        this.type,
        this.fPhone,
        this.fWhatsAppNumber,
        this.fAddress,
        this.fLatitude,
        this.fLongitude,
        this.image,
        this.active,
        this.eventCategory});

  Expired.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    eventCategoryId = json['event_category_id'];
    phone = json['phone'];
    whatsAppNumber = json['whatsApp_number'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    familyName = json['family_name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    type = json['type'];
    fPhone = json['f_phone'];
    fWhatsAppNumber = json['f_whatsApp_number'];
    fAddress = json['f_address'];
    fLatitude = json['f_latitude'];
    fLongitude = json['f_longitude'];
    image = json['image'];
    active = json['active'];
    eventCategory = json['event_category'] != null
        ? new EventCategory.fromJson(json['event_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['event_category_id'] = this.eventCategoryId;
    data['phone'] = this.phone;
    data['whatsApp_number'] = this.whatsAppNumber;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['family_name'] = this.familyName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['type'] = this.type;
    data['f_phone'] = this.fPhone;
    data['f_whatsApp_number'] = this.fWhatsAppNumber;
    data['f_address'] = this.fAddress;
    data['f_latitude'] = this.fLatitude;
    data['f_longitude'] = this.fLongitude;
    data['image'] = this.image;
    data['active'] = this.active;
    if (this.eventCategory != null) {
      data['event_category'] = this.eventCategory!.toJson();
    }
    return data;
  }
}
