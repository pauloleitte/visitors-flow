import '../../notice/models/notice_model.dart';
import '../../visitors/models/visitor_model.dart';

class CeremonyViewModel {
  String? name = "";
  String? description = "";
  DateTime? date = DateTime.now();
  String? id = "";
  List<VisitorModel>? visitors = [];
  List<NoticeModel>? notices = [];

  CeremonyViewModel(
      {this.name,
      this.date,
      this.description,
      this.id,
      this.visitors,
      this.notices});
}
