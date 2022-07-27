import 'package:dartz/dartz.dart';

import '../../../../../../shared/errors/errors.dart';
import '../models/ceremony_model.dart';
import '../repositories/interfaces/ceremony_repository_interface.dart';
import '../view-models/ceremony_view_model.dart';
import 'interfaces/ceremony_service_interface.dart';

class CeremonyService implements ICeremonyService {
  final ICeremonyRepository _ceremonyRepository;
  CeremonyService(this._ceremonyRepository);

  @override
  Future<Either<Failure, CeremonyModel>> createCeremony(
      CeremonyViewModel model) async {
    return await _ceremonyRepository.createCeremony(CeremonyModel(
      name: model.name,
      description: model.description,
      date: model.date,
    ));
  }

  @override
  Future<Either<Failure, List<CeremonyModel>>> getCeremonies() async =>
      await _ceremonyRepository.getCeremonies();

  @override
  Future<Either<Failure, CeremonyModel>> getCeremony(
          CeremonyViewModel model) async =>
      await _ceremonyRepository.getCeremony(model.id.toString());

  @override
  Future<Either<Failure, CeremonyModel>> updateCeremony(
      CeremonyViewModel model) async {
    return await _ceremonyRepository.updateCeremony(CeremonyModel(
        name: model.name, date: model.date, description: model.description));
  }

  @override
  Future<Either<Failure, bool>> deleteCeremony(CeremonyViewModel model) {
    return _ceremonyRepository.deleteCeremony(model.id.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
