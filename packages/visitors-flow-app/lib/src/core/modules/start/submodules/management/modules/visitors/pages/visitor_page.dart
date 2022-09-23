import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../config/app_routes.dart';
import '../models/visitor_model.dart';
import '../widgets/body_visitor.dart';

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
              .pushNamed(AppRoutes.VISITOR_FORM, arguments: VisitorModel());
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
