import '../../member/models/member_model.dart';
import '../../notice/models/notice_model.dart';

class ResponseDepartaments {
  late List<DepartamentModel> departaments;
  int? count;

  ResponseDepartaments({required this.departaments, this.count});

  ResponseDepartaments.fromJson(Map<String, dynamic> json) {
    departaments = <DepartamentModel>[];
    json['departaments'].forEach((v) {
      departaments.add(DepartamentModel.fromJson(v));
    });
    count = json['count'];
  }
}

class DepartamentModel {
  String? sId;
  String? name;
  String? description;
  List<MemberModel>? members;
  List<NoticeModel>? notices;

  DepartamentModel(
      {this.sId, this.name, this.description, this.members, this.notices});

  DepartamentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(MemberModel.fromJson(v));
      });
    }
    if (json['notices'] != null) {
      notices = <NoticeModel>[];
      json['notices'].forEach((v) {
        notices!.add(NoticeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (notices != null) {
      data['notices'] = notices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
