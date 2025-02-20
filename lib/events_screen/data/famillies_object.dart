class FamiliesObject {
  String? familyName;

  FamiliesObject({this.familyName});

  FamiliesObject.fromJson(Map<String, dynamic> json) {
    familyName = json['family_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_name'] = this.familyName;
    return data;
  }
}
