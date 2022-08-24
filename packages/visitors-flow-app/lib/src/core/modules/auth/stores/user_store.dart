import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../models/user_model.dart';
import '../services/interfaces/user_service_interface.dart';

part 'user_store.g.dart';

@Injectable(singleton: false)
// ignore: library_private_types_in_public_api
class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  final IUserService _userService;

  @observable
  late UserModel user = UserModel();

  _UserStoreBase(this._userService);

  @action
  void setUser(UserModel v) {
    user = v;
    _userService.saveLocalDB(v);
  }

  @action
  void clearUser() {
    user = UserModel();
    _userService.saveLocalDB(user);
  }
}
