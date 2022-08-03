import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/widgets/body_ceremony_form.dart';

import '../../../../../config/app_routes.dart';
import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';

class CeremonyFormPage extends StatefulWidget {
  final CeremonyModel? ceremony;
  const CeremonyFormPage({Key? key, this.ceremony}) : super(key: key);

  @override
  State<CeremonyFormPage> createState() => _CeremonyFormPageState();
}

class _CeremonyFormPageState
    extends ModularState<CeremonyFormPage, CeremonyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Culto',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () => Modular.to.navigate(AppRoutes.CEREMONY),
          ),
          actions: [
            ...(widget.ceremony?.name != null
                ? [
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).colorScheme.secondary),
                      onPressed: () async {
                        controller.ceremony = widget.ceremony!;
                        await controller.deleteCeremony();
                        Modular.to.navigate(AppRoutes.CEREMONY);
                      },
                    ),
                  ]
                : [])
          ]),
      body: BodyCeremonyForm(ceremony: widget.ceremony),
    );
  }
}
