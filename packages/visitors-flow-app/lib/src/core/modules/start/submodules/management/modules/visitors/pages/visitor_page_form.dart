// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/visitor_controller.dart';
import '../models/visitor_model.dart';
import '../widgets/body_visitor_form.dart';

class VisitorPageForm extends StatefulWidget {
  final VisitorModel? visitor;
  const VisitorPageForm({Key? key, this.visitor}) : super(key: key);

  @override
  State<VisitorPageForm> createState() => _VisitorPageFormState();
}

class _VisitorPageFormState
    extends ModularState<VisitorPageForm, VisitorController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Visitante',
          ),
          elevation: 0,
          actions: [
            ...(widget.visitor?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        controller.visitor = widget.visitor!;
                        await controller.deleteVisitor();
                        Modular.to.navigate(AppRoutes.VISITOR);
                      },
                    ),
                  ]
                : [])
          ]),
      body: BodyVisitorForm(
        visitor: widget.visitor,
      ),
    );
  }
}
