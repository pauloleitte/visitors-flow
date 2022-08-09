import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../config/app_routes.dart';
import '../../../../auth/stores/user_store.dart';
import '../controllers/profile_controller.dart';

class BodyConfiguration extends StatefulWidget {
  const BodyConfiguration({Key? key}) : super(key: key);

  @override
  State<BodyConfiguration> createState() => _BodyConfigurationState();
}

class _BodyConfigurationState
    extends ModularState<BodyConfiguration, ProfileController> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<UserStore>();
    controller.model = store.user;
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
                              child: Text('${store.user.name}',
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
                              Modular.to.pushNamed(AppRoutes.CONFIG_PROFILE);
                            },
                          ),
                          ListTile(
                            title: const Text('Segurança'),
                            leading: Icon(Icons.security,
                                color: Theme.of(context).primaryColor),
                            onTap: () {
                              Modular.to.pushNamed(AppRoutes.CONFIG_SECURITY);
                            },
                          ),
                          ListTile(
                            title: const Text('Sair'),
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              store.clearUser();
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
