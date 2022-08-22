import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/errors/errors.dart';
import '../../models/ceremony_model.dart';

abstract class ICeremonyRepository implements Disposable {
  Future<Either<Failure, List<CeremonyModel>>> getCeremonies();
  Future<Either<Failure, CeremonyModel>> getCeremony(String id);
  Future<Either<Failure, List<CeremonyModel>>> getCeremoniesOfDay(
      DateTime date);
  Future<Either<Failure, CeremonyModel>> createCeremony(CeremonyModel model);
  Future<Either<Failure, CeremonyModel>> updateCeremony(CeremonyModel model);
  Future<Either<Failure, bool>> deleteCeremony(String id);
}
