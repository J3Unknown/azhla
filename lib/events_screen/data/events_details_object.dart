class EventsDetailsObject {
  int? id;
  String? name;
  String? description;
  int? eventCategoryId;
  String? phone;
  String? whatsAppNumber;
  String? date;
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
  EventCategory? eventCategory;

  EventsDetailsObject(
      {this.id,
        this.name,
        this.description,
        this.eventCategoryId,
        this.phone,
        this.whatsAppNumber,
        this.date,
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
        this.eventCategory});

  EventsDetailsObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    eventCategoryId = json['event_category_id'];
    phone = json['phone'];
    whatsAppNumber = json['whatsApp_number'];
    date = json['date'];
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
