import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    return Observer(builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
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
                                    Theme.of(context).colorScheme.secondary,
                                radius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Theme.of(context).primaryColor,
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
                          title: Text('Editar dados do perfil',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          leading: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onTap: () {
                            Modular.to
                                .pushNamed(AppRoutes.CONFIG_PROFILE,
                                    arguments: controller.model)
                                .then((_) {
                              // you have come back to your Settings screen
                              _getUser();
                            });
                          },
                        ),
                        ListTile(
                          title: Text('Segurança',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          leading: Icon(Icons.security,
                              color: Theme.of(context).colorScheme.secondary),
                          onTap: () {
                            Modular.to.pushNamed(AppRoutes.CONFIG_SECURITY,
                                arguments: controller.model);
                          },
                        ),
                        ListTile(
                          title: Text('Sair',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          leading: Icon(
                            Icons.exit_to_app,
                            color: Theme.of(context).colorScheme.secondary,
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
            ],
          ),
        ),
      );
    });
  }
}
