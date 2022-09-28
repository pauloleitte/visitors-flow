import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/controllers/departament_controller.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/models/departament_model.dart';

import '../../../../../../../config/app_routes.dart';

class BodyDepartament extends StatefulWidget {
  final DepartamentModel? departament;
  const BodyDepartament({Key? key, this.departament}) : super(key: key);

  @override
  State<BodyDepartament> createState() => _BodyDepartamentState();
}

class _BodyDepartamentState
    extends ModularState<BodyDepartament, DepartamentController> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getDepartaments();
  }

  _handleDepartaments() async {
    await controller.getDepartaments();
  }

  Widget getCardDepartament(DepartamentModel departament) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.people_alt_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          departament.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to
              .pushNamed(AppRoutes.DEPARTAMENT_FORM, arguments: departament)
              .then((_) {
            _init();
          });
        },
        subtitle: Text(departament.description!,
            style: const TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: controller.busy
            ? const Center(child: CircularProgressIndicator())
            : controller.departaments.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _handleDepartaments();
                            },
                            child: ListView.builder(
                              itemCount: controller.departaments.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  getCardDepartament(
                                      controller.departaments[i]),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      'Nenhum departamento cadastrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
      );
    });
  }
}
