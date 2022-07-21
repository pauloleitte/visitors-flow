class ImageModel {
  String? sId;
  String? name;
  int? size;
  String? key;
  String? url;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ImageModel(
      {this.sId,
      this.name,
      this.size,
      this.key,
      this.url,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ImageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    size = json['size'];
    key = json['key'];
    url = json['url'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['size'] = this.size;
    data['key'] = this.key;
    data['url'] = this.url;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}