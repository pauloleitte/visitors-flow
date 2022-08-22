import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/auth/stores/token_store.dart';
import 'package:visitors_flow_app/src/core/modules/auth/stores/user_store.dart';
import '../../../../../config/app_routes.dart';
import '../controllers/configuration/configuration_controller.dart';

class BodyConfiguration extends StatefulWidget {
  const BodyConfiguration({Key? key}) : super(key: key);

  @override
  State<BodyConfiguration> createState() => _BodyConfigurationState();
}

class _BodyConfigurationState
    extends ModularState<BodyConfiguration, ConfigurationController> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  Future<void> _getUser() async {
    await controller.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final storeUser = Modular.get<UserStore>();
    final storeToken = Modular.get<TokenStore>();
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            SizedBox(
                                width: 50,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  radius: 50,
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${controller.model.name}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ]),
                          const SizedBox(height: 10.0),
                          // list item menus
                          ListTile(
                            title: const Text('Editar dados do perfil'),
                            leading: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              Modular.to.navigate(AppRoutes.CONFIG_PROFILE,
                                  arguments: controller.model);
                            },
                          ),
                          ListTile(
                            title: const Text('Segurança'),
                            leading: Icon(Icons.security,
                                color: Theme.of(context).primaryColor),
                            onTap: () {
                              Modular.to.pushNamed(AppRoutes.CONFIG_SECURITY,
                                  arguments: controller.model);
                            },
                          ),
                          ListTile(
                            title: const Text('Sair'),
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () async {
                              await controller.logout();
                              Modular.to.navigate(AppRoutes.AUTH);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //myProfile(context),
          ],
        ),
      );
    });
  }
}
