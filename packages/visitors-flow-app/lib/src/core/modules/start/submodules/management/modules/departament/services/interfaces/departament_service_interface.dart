import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

import '../../models/departament_model.dart';
import '../../view-models/departament_view_model.dart';

abstract class IDepartamentService implements Disposable {
  Future<Either<Failure, List<DepartamentModel>>> getDepartaments();
  Future<Either<Failure, DepartamentModel>> getDepartament(
      DepartamentViewModel model);
  Future<Either<Failure, DepartamentModel>> createDepartament(
      DepartamentViewModel model);
  Future<Either<Failure, DepartamentModel>> updateDepartament(
      DepartamentViewModel model);
  Future<Either<Failure, bool>> deleteDepartament(DepartamentViewModel model);
}
