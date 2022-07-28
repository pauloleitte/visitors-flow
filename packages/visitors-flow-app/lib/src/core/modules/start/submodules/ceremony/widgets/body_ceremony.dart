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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await controller.getCeremonies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Stack(
        children: [
          controller.busy
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                  child: ListView.builder(
                    itemCount: controller.ceremonies.length,
                    itemBuilder: (ctx, i) => Column(
                      children: <Widget>[
                        CeremonyItem(controller.ceremonies[i]),
                        const Divider(),
                      ],
                    ),
                  ),
                )
        ],
      );
    });
  }
}
