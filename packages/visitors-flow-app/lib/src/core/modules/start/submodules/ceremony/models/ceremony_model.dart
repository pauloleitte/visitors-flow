import 'package:visitors_flow_app/src/core/modules/start/submodules/visitors/models/visitor_model.dart';

class ResponseCeremonies {
  late List<CeremonyModel> ceremonies;
  int? count;

  ResponseCeremonies({required this.ceremonies, this.count});

  ResponseCeremonies.fromJson(Map<String, dynamic> json) {
    ceremonies = <CeremonyModel>[];
    json['ceremonies'].forEach((v) {
      ceremonies.add(CeremonyModel.fromJson(v));
    });
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['ceremonies'] = ceremonies.map((v) => v.toJson()).toList();

    data['count'] = count;
    return data;
  }
}

class CeremonyModel {
  String? sId;
  String? name;
  String? description;
  String? date;
  List<VisitorModel>? visitors;
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
      visitors = <VisitorModel>[];
      json['visitors'].forEach((v) {
        visitors!.add(VisitorModel.fromJson(v));
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
