class VisitorModel {
  String? sId;
  String? name;
  String? email;
  String? telephone;
  bool? isChurchgoer;
  String? church;
  String? observations;
  int? iV;

  VisitorModel(
      {this.sId,
      this.name,
      this.email,
      this.telephone,
      this.isChurchgoer,
      this.church,
      this.observations,
      this.iV});

  VisitorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    isChurchgoer = json['isChurchgoer'];
    church = json['church'];
    observations = json['observations'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['telephone'] = telephone;
    data['isChurchgoer'] = isChurchgoer;
    data['church'] = church;
    data['observations'] = observations;
    data['__v'] = iV;
    return data;
  }
}