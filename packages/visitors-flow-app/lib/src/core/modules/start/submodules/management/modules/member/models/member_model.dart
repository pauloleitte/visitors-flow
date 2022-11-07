class ResponseMembers {
  late List<MemberModel> members;
  int? count;

  ResponseMembers({required this.members, this.count});

  ResponseMembers.fromJson(Map<String, dynamic> json) {
    members = <MemberModel>[];
    json['members'].forEach((v) {
      members.add(MemberModel.fromJson(v));
    });

    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['members'] = members.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class MemberModel {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? job;
  DateTime? birthday;
  String? genre;

  MemberModel(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.job,
      this.genre,
      this.birthday});

  MemberModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    job = json['job'];
    genre = json['genre'];
    birthday =
        json["birthday"] == null ? null : DateTime.parse(json["birthday"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['job'] = job;
    data['genre'] = genre;
    if (birthday == null) {
      data["birthday"] = null;
    } else {
      data["birthday"] = birthday?.toIso8601String();
    }
    return data;
  }
}
