import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import '../controllers/visitor_controller.dart';
import '../models/visitor_model.dart';

class VisitorItem extends StatefulWidget {
  final VisitorModel visitor;

  const VisitorItem(this.visitor, {Key? key}) : super(key: key);

  @override
  State<VisitorItem> createState() => _VisitorItemState();
}

class _VisitorItemState extends ModularState<VisitorItem, VisitorController> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.visitor.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to
              .navigate(AppRoutes.VISITOR_FORM, arguments: widget.visitor);
        },
        subtitle: Text(
          '${widget.visitor.email}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
