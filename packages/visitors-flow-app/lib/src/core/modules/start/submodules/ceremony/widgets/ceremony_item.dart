import 'package:flutter/material.dart';

import '../models/ceremony_model.dart';

class CeremonyItem extends StatelessWidget {
  final CeremonyModel ceremony;

  const CeremonyItem(this.ceremony, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        title: Text(
          ceremony.name!,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          _showOptions(context);
        },
        subtitle: Text(
          '${ceremony.name}',
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
                        leading: const Icon(Icons.add),
                        title: const Text('Cadastrar Visitante'),
                        onTap: () {
                          print('adicionar visitante');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Editar'),
                        onTap: () {
                          print('adicionar visitante');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Excluir'),
                        onTap: () {
                          print('adicionar visitante');
                        },
                      ),
                    ],
                  ));
            },
          );
        });
  }
}
