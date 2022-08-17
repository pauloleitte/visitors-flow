import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/controllers/profile_controller.dart';

import '../../../../../config/theme_helper.dart';
import '../../../../auth/stores/user_store.dart';

class BodySecurity extends StatefulWidget {
  BodySecurity({Key? key}) : super(key: key);

  @override
  State<BodySecurity> createState() => _BodySecurityState();
}

class _BodySecurityState extends ModularState<BodySecurity, ProfileController> {
  final _formKey = GlobalKey<FormState>();
  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await controller.updatePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<UserStore>();
    controller.model = store.user;
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    obscureText: true,
                    decoration: ThemeHelper().textInputDecoration(
                        'Senha Atual', 'Insira seu senha atual'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Insira sua senha atual';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    obscureText: true,
                    decoration: ThemeHelper().textInputDecoration(
                        'Nova senha', 'Insira seu nova senha'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Insira sua nova senha';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.vm.password = value;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: controller.busy ? null : save,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Alterar".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
