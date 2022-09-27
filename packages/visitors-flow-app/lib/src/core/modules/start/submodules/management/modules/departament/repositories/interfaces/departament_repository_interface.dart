import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';
import '../../models/departament_model.dart';

abstract class IDepartamentRepository implements Disposable {
  Future<Either<Failure, List<DepartamentModel>>> getDepartaments();
  Future<Either<Failure, DepartamentModel>> getDepartament(String id);
  Future<Either<Failure, DepartamentModel>> createDepartament(DepartamentModel model);
  Future<Either<Failure, DepartamentModel>> updateDepartament(DepartamentModel model);
  Future<Either<Failure, bool>> deleteDepartament(String id);
}
