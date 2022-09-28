import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/visitors/models/visitor_model.dart';
import '../../../../../../../config/app_routes.dart';
import '../controllers/visitor_controller.dart';

class BodyVisitor extends StatefulWidget {
  const BodyVisitor({Key? key}) : super(key: key);

  @override
  State<BodyVisitor> createState() => _BodyVisitorState();
}

class _BodyVisitorState extends ModularState<BodyVisitor, VisitorController> {
  @override
  void initState() {
    super.initState();
    _handleVisitors();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleVisitors() async {
    await controller.getVisitors();
  }

  Widget getCardVisitor(VisitorModel visitor) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          visitor.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.navigate(AppRoutes.VISITOR_FORM, arguments: visitor);
        },
        subtitle: Text(
          '${visitor.email}',
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
                                  getCardVisitor(controller.visitors[i]),
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
