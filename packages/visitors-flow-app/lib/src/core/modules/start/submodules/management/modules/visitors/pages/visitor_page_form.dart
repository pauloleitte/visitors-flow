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
          title: Text(
            'Visitante',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.VISITOR),
          ),
          actions: [
            ...(widget.visitor?.name != null
                ? [
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).primaryColor),
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
