import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/models/departament_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/widgets/body_departament_form.dart';

import '../controllers/departament_controller.dart';

class DepartamentFormPage extends StatefulWidget {
  final DepartamentModel? departament;
  const DepartamentFormPage({Key? key, this.departament}) : super(key: key);

  @override
  State<DepartamentFormPage> createState() => _DepartamentFormPageState();
}

class _DepartamentFormPageState
    extends ModularState<DepartamentFormPage, DepartamentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Departamento',
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.DEPARTAMENT),
          ),
          actions: [
            ...(widget.departament?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        controller.departament = widget.departament!;
                        await controller.deleteDepartament();
                        Modular.to.navigate(AppRoutes.DEPARTAMENT);
                      },
                    ),
                  ]
                : [])
          ]),
      body: BodyDepartamentForm(departament: widget.departament),
    );
  }
}
