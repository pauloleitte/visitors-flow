import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/auth/models/token_model.dart';

abstract class ITokenService implements Disposable {
  Future<TokenModel> getCurrentToken();
  Future<void> saveLocalDB(TokenModel model);
}
