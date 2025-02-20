class AboutUs {
  int? id;
  String? whatsappNumber;
  String? facebook;
  String? insta;
  String? youtube;
  String? description;
  String? terms;
  String? privacy;
  String? createdAt;

  AboutUs(
      {this.id,
        this.whatsappNumber,
        this.facebook,
        this.insta,
        this.youtube,
        this.description,
        this.terms,
        this.privacy,
        this.createdAt});

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    whatsappNumber = json['whatsapp_number'];
    facebook = json['facebook'];
    insta = json['insta'];
    youtube = json['youtube'];
    description = json['description'];
    terms = json['terms'];
    privacy = json['privacy'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['whatsapp_number'] = this.whatsappNumber;
    data['facebook'] = this.facebook;
    data['insta'] = this.insta;
    data['youtube'] = this.youtube;
    data['description'] = this.description;
    data['terms'] = this.terms;
    data['privacy'] = this.privacy;
    data['created_at'] = this.createdAt;
    return data;
  }
}
