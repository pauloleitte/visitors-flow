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
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        title: Text(
          widget.visitor.name!,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          _showOptions(context, widget.visitor);
        },
        subtitle: Text(
          '${widget.visitor.email}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, VisitorModel model) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.grey.shade100,
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Editar'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Modular.to.pushNamed(AppRoutes.VISITOR_FORM,
                            arguments: model);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Excluir'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _openDialog(context, widget.visitor);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _openDialog(BuildContext context, VisitorModel model) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: const Text('Deseja realmente excluir este visitante?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Excluir'),
              onPressed: () {
                controller.visitor = model;
                controller.deleteVisitor();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
