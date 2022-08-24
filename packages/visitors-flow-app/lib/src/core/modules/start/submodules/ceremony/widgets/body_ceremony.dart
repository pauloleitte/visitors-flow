import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/shared/widgets/title_widget.dart';
import '../controllers/ceremony_controller.dart';
import 'ceremony_item.dart';

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
    init();
  }

  init() async {
    await controller.getCeremonies();
  }

  _handleCeremonies() async {
    await controller.getCeremonies();
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
                        buildTitle(title: 'Cultos'),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _handleCeremonies();
                            },
                            child: ListView.builder(
                              itemCount: controller.ceremonies.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  CeremonyItem(controller.ceremonies[i]),
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
