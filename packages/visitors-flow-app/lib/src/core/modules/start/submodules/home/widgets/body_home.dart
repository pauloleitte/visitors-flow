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

  Widget getCalendarOfWeek() {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.calendar_month,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          "Bla Bla Bla Bla",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        subtitle: Text(
          "22-10-2022",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget getCard(CeremonyModel ceremony) {
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
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.CEREMONY_FORM, arguments: ceremony);
        },
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(ceremony.date!),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: SafeArea(
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
                            context: context,
                            title:
                                'Olá, ${controller.model.name.toString().split(' ')[0]}'),
                        const SizedBox(
                          height: 10,
                        ),
                        subTitle(title: 'Agenda da semana', context: context),
                        const SizedBox(
                          height: 10,
                        ),
                        getCalendarOfWeek(),
                        (controller.ceremonies.isNotEmpty
                            ? SizedBox(
                                height: controller.ceremonies.length == 1
                                    ? MediaQuery.of(context).size.height / 3
                                    : MediaQuery.of(context).size.height / 2,
                                child: Column(
                                  children: [
                                    subTitle(
                                        title: 'Cultos Hoje', context: context),
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
                                    ),
                                  ],
                                ),
                              )
                            : subTitle(
                                title: 'Nenhum culto para o dia',
                                context: context)),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
