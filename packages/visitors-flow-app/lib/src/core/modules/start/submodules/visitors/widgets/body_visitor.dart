import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/visitor_controller.dart';
import 'visitor_item.dart';

class BodyVisitor extends StatefulWidget {
  const BodyVisitor({Key? key}) : super(key: key);

  @override
  State<BodyVisitor> createState() => _BodyVisitorState();
}

class _BodyVisitorState extends ModularState<BodyVisitor, VisitorController> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await controller.getVisitors();
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
                    itemCount: controller.visitors.length,
                    itemBuilder: (ctx, i) => Column(
                      children: <Widget>[
                        VisitorItem(controller.visitors[i]),
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
