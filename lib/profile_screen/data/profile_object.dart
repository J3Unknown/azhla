class ProfileObject {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? providerId;
  String? providerName;
  String? lang;
  List<Address>? address;

  ProfileObject(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.providerId,
        this.providerName,
        this.lang,
        this.address});

  ProfileObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    providerId = json['provider_id'];
    providerName = json['provider_name'];
    lang = json['lang'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
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
    data['provider_id'] = this.providerId;
    data['provider_name'] = this.providerName;
    data['lang'] = this.lang;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? floorNo;
  String? flatNo;
  String? buildingNo;
  String? blockNo;
  String? street;
  String? notes;
  Region? region;
  RegionParent? regionParent;

  Address(
      {this.id,
        this.floorNo,
        this.flatNo,
        this.buildingNo,
        this.blockNo,
        this.street,
        this.notes,
        this.region,
        this.regionParent});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floorNo = json['floor_no'];
    flatNo = json['flat_no'];
    buildingNo = json['building_no'];
    blockNo = json['block_no'];
    street = json['street'];
    notes = json['notes'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionParent = json['region_parent'] != null
        ? new RegionParent.fromJson(json['region_parent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['floor_no'] = this.floorNo;
    data['flat_no'] = this.flatNo;
    data['building_no'] = this.buildingNo;
    data['block_no'] = this.blockNo;
    data['street'] = this.street;
    data['notes'] = this.notes;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.regionParent != null) {
      data['region_parent'] = this.regionParent!.toJson();
    }
    return data;
  }
}

class Region {
  int? id;
  int? parentId;
  String? name;

  Region({this.id, this.parentId, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    return data;
  }
}

class RegionParent {
  int? id;
  Null? parentId;
  String? name;

  RegionParent({this.id, this.parentId, this.name});

  RegionParent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    return data;
  }
}
