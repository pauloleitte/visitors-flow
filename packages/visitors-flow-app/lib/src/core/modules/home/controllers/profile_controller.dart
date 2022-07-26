import 'package:mobx/mobx.dart';

import '../../auth/models/user_model.dart';
import '../../auth/services/user_service.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  UserModel userModel = UserModel();

  @computed
  UserModel get model => userModel;

  UserService service;

  _ProfileControllerBase(this.service);

  Future<void> getUser() async {
    userModel = await service.getCurrentUser();
  }
}
