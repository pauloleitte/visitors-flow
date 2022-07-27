import 'package:mobx/mobx.dart';

import '../../../../auth/models/user_model.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  UserModel model = UserModel();

  _ProfileControllerBase();
}
