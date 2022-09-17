import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../../../../../../shared/widgets/subtitle_widget.dart';
import '../../../../../../shared/widgets/title_widget.dart';
import '../../management/modules/ceremony/models/ceremony_model.dart';
import '../controllers/home_controller.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

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
    await controller.getCeremoniesOfDay(DateTime.now().toUtc().toLocal());
    await controller.getUser();
  }

  Widget getCard(CeremonyModel ceremony) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.church,
            color: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: controller.busy
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      buildTitle(
                          title:
                              'Olá, ${controller.model.name.toString().split(' ')[0]}'),
                      const SizedBox(
                        height: 10,
                      ),
                      (controller.ceremonies.isNotEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              child: Column(
                                children: [
                                  subTitle(title: 'Cultos'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: ListView.builder(
                                          itemCount:
                                              controller.ceremonies.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return getCard(
                                                controller.ceremonies[index]);
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : subTitle(title: 'Nenhum culto para o dia')),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
