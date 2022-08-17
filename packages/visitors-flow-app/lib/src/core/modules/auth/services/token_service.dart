import 'dart:convert';
import './interfaces/token_service_interface.dart';

import '../../../../shared/services/local_storage_service.dart';
import '../models/token_model.dart';

class TokenService implements ITokenService {
  TokenService();

  @override
  void dispose() {}

  @override
  Future<TokenModel> getCurrentToken() async {
    var contains = await LocalStorageService.cointains('current_token');
    if (contains) {
      var res = jsonDecode(
          await LocalStorageService.getValue<String>('current_token'));
      return TokenModel.fromJson(res);
    } else {
      return TokenModel();
    }
  }

  @override
  Future<void> saveLocalDB(TokenModel model) async {
    LocalStorageService.setValue<String>(
        'current_token', jsonEncode(model.toJson()));
  }
}
