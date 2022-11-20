import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/visitors/models/visitor_model.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/visitor_controller.dart';

class BodyVisitor extends StatefulWidget {
  const BodyVisitor({Key? key}) : super(key: key);

  @override
  State<BodyVisitor> createState() => _BodyVisitorState();
}

class _BodyVisitorState extends ModularState<BodyVisitor, VisitorController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  List<VisitorModel> copy = [];

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
    copy.addAll(controller.visitors);
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
          Modular.to.pushNamed(AppRoutes.VISITOR_DETAIL, arguments: visitor);
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

  filterSearchResults(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      List<VisitorModel> dummyCopy = [];
      dummyCopy.addAll(controller.visitors);
      if (query.isNotEmpty) {
        List<VisitorModel> dummyListData = [];
        for (var item in dummyCopy) {
          if (item.name!.contains(query)) {
            dummyListData.add(item);
          }
        }
        setState(() {
          controller.visitors.clear();
          controller.visitors.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          controller.visitors.clear();
          controller.visitors.addAll(copy);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
          child: controller.busy
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: ThemeHelper().textInputDecoration(
                              'Nome',
                              'Insira o nome do visitante',
                              const Icon(Icons.search)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      controller.visitors.isNotEmpty
                          ? Expanded(
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
                            )
                          : const Center(
                              child: Text(
                                'Nenhum visitante encontrado',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ));
    });
  }
}
