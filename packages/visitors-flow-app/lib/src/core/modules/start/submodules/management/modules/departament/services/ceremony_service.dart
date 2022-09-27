import 'package:dartz/dartz.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/repositories/interfaces/departament_repository_interface.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/services/interfaces/departament_service_interface.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

import '../models/departament_model.dart';
import '../view-models/departament_view_model.dart';

class DepartamentService implements IDepartamentService {
  final IDepartamentRepository _departamentRepository;
  DepartamentService(this._departamentRepository);

  @override
  Future<Either<Failure, DepartamentModel>> createDepartament(
      DepartamentViewModel model) async {
    return await _departamentRepository.createDepartament(DepartamentModel(
        name: model.name,
        description: model.description,
        notices: model.notices,
        members: model.members));
  }

  @override
  Future<Either<Failure, List<DepartamentModel>>> getDepartaments() async =>
      await _departamentRepository.getDepartaments();

  @override
  Future<Either<Failure, DepartamentModel>> getDepartament(
          DepartamentViewModel model) async =>
      await _departamentRepository.getDepartament(model.id.toString());

  @override
  Future<Either<Failure, DepartamentModel>> updateDepartament(
      DepartamentViewModel model) async {
    return await _departamentRepository.updateDepartament(DepartamentModel(
        sId: model.id,
        name: model.name,
        members: model.members,
        notices: model.notices,
        description: model.description));
  }

  @override
  Future<Either<Failure, bool>> deleteDepartament(DepartamentViewModel model) {
    return _departamentRepository.deleteDepartament(model.id.toString());
  }

  @override
  void dispose() {}
}
