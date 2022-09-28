import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../../../../../config/app_routes.dart';
import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';

class BodyCeremony extends StatefulWidget {
  const BodyCeremony({Key? key}) : super(key: key);

  @override
  State<BodyCeremony> createState() => _BodyCeremonyState();
}

class _BodyCeremonyState
    extends ModularState<BodyCeremony, CeremonyController> {
  @override
  void initState() {
    super.initState();
    _handleCeremonies();
  }

  _handleCeremonies() async {
    await controller.getCeremonies();
  }

  Widget getCardCeremony(CeremonyModel ceremony) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.church,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          ceremony.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.navigate(AppRoutes.CEREMONY_FORM, arguments: ceremony);
        },
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(ceremony.date!),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: controller.busy
            ? const Center(child: CircularProgressIndicator())
            : controller.ceremonies.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _handleCeremonies();
                            },
                            child: ListView.builder(
                              itemCount: controller.ceremonies.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  getCardCeremony(controller.ceremonies[i]),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      'Nenhum culto cadastrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
      );
    });
  }
}
