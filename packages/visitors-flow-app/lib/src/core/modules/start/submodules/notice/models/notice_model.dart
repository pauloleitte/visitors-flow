class ResponseNotices {
  late List<NoticeModel> notices;
  int? count;

  ResponseNotices({required this.notices, this.count});

  ResponseNotices.fromJson(Map<String, dynamic> json) {
    notices = <NoticeModel>[];
    json['notices'].forEach((v) {
      notices.add(NoticeModel.fromJson(v));
    });

    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notices'] = notices.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class NoticeModel {
  String? sId;
  String? name;
  String? description;
  bool? isDone;

  NoticeModel({this.sId, this.name, this.description, this.isDone});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['isDone'] = isDone;
    return data;
  }
}
