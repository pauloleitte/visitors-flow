import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/member/models/member_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/notice/models/notice_model.dart';

class DepartamentViewModel {
  String? name = "";
  String? description = "";
  String? id = "";
  List<MemberModel>? members = [];
  List<NoticeModel>? notices = [];

  DepartamentViewModel(
      {this.name, this.description, this.id, this.members, this.notices});
}
