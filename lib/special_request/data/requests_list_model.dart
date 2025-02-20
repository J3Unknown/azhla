class RequestsListModel{
  bool? success;
  List<Result>? result;
  String? msg;

  RequestsListModel({this.success, this.result, this.msg});

  RequestsListModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((value) {
        result!.add(Result.fromJson(value));
      });
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((value) => value.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class Result{
  int? id;
  int? userId;
  int? categoryId;
  String? familyName;
  int? areaId;
  int? budget;
  String? date;
  String? time;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? requestNumber;
  List<SpecialRequestDetails>? specialRequestDetails = [];
  Category? category;

  Result({
    this.id,
    this.userId,
    this.categoryId,
    this.familyName,
    this.areaId,
    this.budget,
    this.date,
    this.time,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.requestNumber,
    this.specialRequestDetails,
    this.category
  });

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    familyName = json['family_name'];
    areaId = json['area_id'];
    budget = json['budget'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    requestNumber = json['request_number'];
    if(json['special_request_details'] != null) {
      json['special_request_details'].forEach((value){
        specialRequestDetails!.add(SpecialRequestDetails.fromJson(value));
      });
    }
    category = Category.fromJson(json['category']);
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['family_name'] = familyName;
    data['area_id'] = areaId;
    data['budget'] = budget;
    data['date'] = date;
    data['time'] = time;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['request_number'] = requestNumber;
    if(data['special_request_details'] != null) {
      data['special_request_details'] = specialRequestDetails!.map((value) => value.toJson()).toList();
    }
    category != null? data['category'] = category!.toJson():null;
    return data;
  }
}

class SpecialRequestDetails{
  int? id;
  int? specialRequestId;
  int? userId;
  String? type;
  String? content;
  String? role;
  String? createdAt;
  String? updatedAt;

  SpecialRequestDetails({
    this.id,
    this.specialRequestId,
    this.userId,
    this.type,
    this.content,
    this.role,
    this.createdAt,
    this.updatedAt
  });

  SpecialRequestDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    specialRequestId = json['special_request_id'];
    userId = json['user_id'];
    type = json['type'];
    content = json['content'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['special_request_id'] = specialRequestId;
    data['user_id'] = userId;
    data['type'] = type;
    data['content'] = content;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}

class Category{
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}