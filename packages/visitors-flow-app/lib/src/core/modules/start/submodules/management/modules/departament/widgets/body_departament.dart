import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/controllers/departament_controller.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/models/departament_model.dart';
import 'package:visitors_flow_app/src/shared/widgets/title_widget.dart';

import 'departament_item.dart';

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
    init();
  }

  init() async {
    await controller.getDepartaments();
  }

  _handleDepartaments() async {
    await controller.getDepartaments();
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
                        buildTitle(title: 'Departamentos'),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _handleDepartaments();
                            },
                            child: ListView.builder(
                              itemCount: controller.departaments.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  DepartamentItem(controller.departaments[i]),
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
