class SignUpObject {
  String? name;
  String? phone;
  int? id;
  String? token;

  SignUpObject({this.name, this.phone, this.id, this.token});

  SignUpObject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
