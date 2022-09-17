import 'package:dartz/dartz.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

import '../models/visitor_model.dart';
import '../repositories/visitor_repository.dart';
import '../view-model/visitor_view_model.dart';
import 'interfaces/visitor_service_interfaces.dart';

class VisitorService implements IVisitorService {
  final VisitorRepository _repository;

  VisitorService(this._repository);

  @override
  Future<Either<Failure, VisitorModel>> createVisitor(VisitorViewModel model) {
    return _repository.createVisitor(VisitorModel(
      church: model.church,
      name: model.name,
      email: model.email,
      telephone: model.telephone,
      isChurchgoer: model.isChurchgoer,
      observations: model.observations,
    ));
  }

  @override
  Future<Either<Failure, bool>> deleteVisitor(VisitorViewModel model) {
    return _repository.deleteVisitor(model.id.toString());
  }

  @override
  Future<Either<Failure, VisitorModel>> getVisitor(VisitorViewModel model) {
    return _repository.getVisitor(model.id.toString());
  }

  @override
  Future<Either<Failure, List<VisitorModel>>> getVisitors() {
    return _repository.getVisitors();
  }

  @override
  Future<Either<Failure, List<VisitorModel>>> getVisitorsByName(String filter) {
    return _repository.getVisitorsByName(filter);
  }

  @override
  Future<Either<Failure, VisitorModel>> updateVisitor(VisitorViewModel model) {
    return _repository.updateVisitor(VisitorModel(
      sId: model.id,
      church: model.church,
      name: model.name,
      email: model.email,
      telephone: model.telephone,
      isChurchgoer: model.isChurchgoer,
      observations: model.observations,
    ));
  }

  @override
  void dispose() {}
}
