import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/models/ceremony_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/widgets/body_ceremony_report.dart';

import '../../../../../config/app_routes.dart';

class CeremonyReportPage extends StatefulWidget {
  final CeremonyModel? ceremony;
  CeremonyReportPage({Key? key, this.ceremony}) : super(key: key);

  @override
  State<CeremonyReportPage> createState() => _CeremonyReportPageState();
}

class _CeremonyReportPageState extends State<CeremonyReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Culto'), actions: [
          IconButton(
            icon: Icon(Icons.edit,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () async {
              Modular.to.navigate(AppRoutes.CEREMONY_FORM,
                  arguments: widget.ceremony);
            },
          ),
        ]),
        body: BodyCeremonyRerport(
          ceremony: widget.ceremony!,
        ));
  }
}
