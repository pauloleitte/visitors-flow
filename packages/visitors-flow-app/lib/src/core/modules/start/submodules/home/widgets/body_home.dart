import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/models/ceremony_model.dart';

import '../../../../auth/stores/user_store.dart';
import '../controllers/home_controller.dart';

class BodyHome extends StatefulWidget {
  BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends ModularState<BodyHome, HomeController> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    await controller
        .getCeremoniesOfDay(DateTime.now().toUtc().toLocal().toString());
    await controller.getUser();
  }

  Widget getCard(CeremonyModel model) {
    return SizedBox(
      height: 50,
      child: Card(
        child: Center(
            child: Text(
          model.name ?? '',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text(
                'Olá, ${controller.model.name.toString().split(' ')[0]}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              (controller.ceremonies.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Column(
                        children: [
                          Text('Cultos do dia',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              child: ListView.builder(
                                  itemCount: controller.ceremonies.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return getCard(
                                        controller.ceremonies[index]);
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  : const Text('Nenhum culto para o dia')),
            ],
          ),
        ),
      );
    });
  }
}
