import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    controller.model.genre == "Masculino"
                        ? SvgPicture.asset("assets/images/bighead_man.svg",
                            height: 150)
                        : SvgPicture.asset("assets/images/bighead_womam.svg",
                            height: 150),
                    const SizedBox(height: 10.0),
                    Text('${controller.model.name}',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center),
                    Text('${controller.model.email}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20.0),
                    // list item menus
                    Card(
                      child: ListTile(
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
                    ),
                    Card(
                      child: ListTile(
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
                    ),
                    Card(
                      child: ListTile(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
