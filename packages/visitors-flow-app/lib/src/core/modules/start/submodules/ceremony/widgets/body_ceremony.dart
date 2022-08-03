import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/ceremony_controller.dart';
import 'ceremony_item.dart';

class BodyCeremony extends StatefulWidget {
  const BodyCeremony({Key? key}) : super(key: key);

  @override
  State<BodyCeremony> createState() => _BodyCeremonyState();
}

class _BodyCeremonyState
    extends ModularState<BodyCeremony, CeremonyController> {
  Timer? _debounce;
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
      return Stack(
        children: [
          controller.busy
              ? const Center(child: CircularProgressIndicator())
              : controller.ceremonies.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
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
                    )
                  : const Center(
                      child: Text(
                        'Nenhum culto cadastrado',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
        ],
      );
    });
  }
}
