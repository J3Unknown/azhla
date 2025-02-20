class NotificationsDTO {
  int? id;
  String? name;
  String? description;
  String? type;
  String? updatedAt;
  String? read;

  NotificationsDTO(
      {this.id, this.name, this.description, this.type, this.updatedAt,this.read});

  NotificationsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    read = json['read'].toString();
    description = json['description'];
    type = json['type'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['read'] = this.read;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}