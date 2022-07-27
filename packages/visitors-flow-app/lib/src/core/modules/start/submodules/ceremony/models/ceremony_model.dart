class CeremonyModel {
  String? sId;
  String? name;
  String? description;
  String? date;
  List<Visitors>? visitors;
  int? iV;

  CeremonyModel(
      {this.sId,
      this.name,
      this.description,
      this.date,
      this.visitors,
      this.iV});

  CeremonyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    date = json['date'];
    if (json['visitors'] != null) {
      visitors = <Visitors>[];
      json['visitors'].forEach((v) {
        visitors!.add(Visitors.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['date'] = date;
    if (visitors != null) {
      data['visitors'] = visitors!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class Visitors {
  String? sId;
  String? name;
  int? iV;

  Visitors({this.sId, this.name, this.iV});

  Visitors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    return data;
  }
}
