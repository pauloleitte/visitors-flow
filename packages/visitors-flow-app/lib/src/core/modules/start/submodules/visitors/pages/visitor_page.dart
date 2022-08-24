import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/visitors/models/visitor_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/visitors/widgets/body_visitor.dart';

import '../../../../../config/app_routes.dart';

class VisitorPage extends StatefulWidget {
  const VisitorPage({Key? key}) : super(key: key);

  @override
  State<VisitorPage> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const BodyVisitor(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to
              .navigate(AppRoutes.VISITOR_FORM, arguments: VisitorModel());
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
