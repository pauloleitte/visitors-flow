import 'package:flutter/material.dart';

import '../models/visitor_model.dart';

class VisitorItem extends StatelessWidget {
  final VisitorModel visitor;

  const VisitorItem(this.visitor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        title: Text(
          visitor.name!,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          _showOptions(context);
        },
        subtitle: Text(
          '${visitor.email}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
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
                        print('EDITAR visitante');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Excluir'),
                      onTap: () {
                        print('EXCLUIR visitante');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
