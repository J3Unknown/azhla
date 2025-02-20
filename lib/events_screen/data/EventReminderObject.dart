import 'events_details_object.dart';

class EventReminderObject {
  int? userDailyEventId;
  int? dailyEventId;
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
  DailyEvent? dailyEvent;

  EventReminderObject(
      {this.userDailyEventId,
        this.dailyEventId,
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
        this.dailyEvent});

  EventReminderObject.fromJson(Map<String, dynamic> json) {
    userDailyEventId = json['user_daily_event_id'];
    dailyEventId = json['daily_event_id'];
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
    dailyEvent = json['daily_event'] != null
        ? new DailyEvent.fromJson(json['daily_event'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_daily_event_id'] = this.userDailyEventId;
    data['daily_event_id'] = this.dailyEventId;
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
    if (this.dailyEvent != null) {
      data['daily_event'] = this.dailyEvent!.toJson();
    }
    return data;
  }
  EventsDetailsObject toEventsDetailsObject() {
    return EventsDetailsObject(
      id: this.dailyEventId,
      name: name,
      description: description,
      eventCategoryId: eventCategoryId,
      phone: phone,
      whatsAppNumber: whatsAppNumber,
      date: date,
      address: address,
      familyName: familyName,
      longitude: longitude,
      latitude: latitude,
      type: type,
      fPhone: fPhone,
      fWhatsAppNumber: fWhatsAppNumber,
      fAddress: fAddress,
      fLatitude: fLatitude,
      fLongitude: fLongitude,
      image: image,
      eventCategory: dailyEvent?.eventCategory,
    );
  }
}

class DailyEvent {
  int? id;
  int? eventCategoryId;
  int? cityId;
  String? type;
  String? fPhone;
  String? fWhatsAppNumber;
  String? fAddress;
  String? fLatitude;
  String? fLongitude;
  String? phone;
  String? whatsAppNumber;
  String? date;
  String? address;
  String? familyName;
  String? descriptionAr;
  String? descriptionEn;
  String? longitude;
  String? latitude;
  String? nameAr;
  String? nameEn;
  String? image;
  EventCategory? eventCategory;

  DailyEvent(
      {this.id,
        this.eventCategoryId,
        this.cityId,
        this.type,
        this.fPhone,
        this.fWhatsAppNumber,
        this.fAddress,
        this.fLatitude,
        this.fLongitude,
        this.phone,
        this.whatsAppNumber,
        this.date,
        this.address,
        this.familyName,
        this.descriptionAr,
        this.descriptionEn,
        this.longitude,
        this.latitude,
        this.nameAr,
        this.nameEn,
        this.image,
        this.eventCategory});

  DailyEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventCategoryId = json['event_category_id'];
    cityId = json['city_id'];
    type = json['type'];
    fPhone = json['f_phone'];
    fWhatsAppNumber = json['f_whatsApp_number'];
    fAddress = json['f_address'];
    fLatitude = json['f_latitude'];
    fLongitude = json['f_longitude'];
    phone = json['phone'];
    whatsAppNumber = json['whatsApp_number'];
    date = json['date'];
    address = json['address'];
    familyName = json['family_name'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = json['image'];
    eventCategory = json['event_category'] != null
        ? new EventCategory.fromJson(json['event_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_category_id'] = this.eventCategoryId;
    data['city_id'] = this.cityId;
    data['type'] = this.type;
    data['f_phone'] = this.fPhone;
    data['f_whatsApp_number'] = this.fWhatsAppNumber;
    data['f_address'] = this.fAddress;
    data['f_latitude'] = this.fLatitude;
    data['f_longitude'] = this.fLongitude;
    data['phone'] = this.phone;
    data['whatsApp_number'] = this.whatsAppNumber;
    data['date'] = this.date;
    data['address'] = this.address;
    data['family_name'] = this.familyName;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    if (this.eventCategory != null) {
      data['event_category'] = this.eventCategory!.toJson();
    }
    return data;
  }

}

// class EventCategory {
//   int? id;
//   String? name;
//   String? image;
//
//   EventCategory({this.id, this.name, this.image});
//
//   EventCategory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     return data;
//   }
//
// }
