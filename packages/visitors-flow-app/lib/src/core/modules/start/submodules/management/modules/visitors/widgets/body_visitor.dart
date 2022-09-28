import 'dart:async';

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
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _handleVisitors();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _handleVisitors() async {
    await controller.getVisitors();
  }

  // _onSearchChanged(String query) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     controller.filter = query;
  //     controller.getVisitorsByName();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: controller.busy
            ? const Center(child: CircularProgressIndicator())
            : controller.visitors.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await _handleVisitors();
                            },
                            child: ListView.builder(
                              itemCount: controller.visitors.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  VisitorItem(controller.visitors[i]),
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
                      'Nenhum visitante cadastrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
      );
    });
  }
}
