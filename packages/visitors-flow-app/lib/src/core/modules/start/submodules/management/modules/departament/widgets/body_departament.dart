import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/controllers/departament_controller.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/models/departament_model.dart';

import '../../../../../../../config/app_routes.dart';

class BodyDepartament extends StatefulWidget {
  final DepartamentModel? departament;
  const BodyDepartament({Key? key, this.departament}) : super(key: key);

  @override
  State<BodyDepartament> createState() => _BodyDepartamentState();
}

class _BodyDepartamentState
    extends ModularState<BodyDepartament, DepartamentController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  List<DepartamentModel> copy = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getDepartaments();
    copy.addAll(controller.departaments);
  }

  _handleDepartaments() async {
    await controller.getDepartaments();
  }

  Widget getCardDepartament(DepartamentModel departament) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.people_alt_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          departament.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to
              .pushNamed(AppRoutes.DEPARTAMENT_DETAIL, arguments: departament);
        },
        subtitle: Text(departament.description!,
            style: const TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }

  filterSearchResults(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      List<DepartamentModel> dummyCopy = [];
      dummyCopy.addAll(controller.departaments);
      if (query.isNotEmpty) {
        List<DepartamentModel> dummyListData = [];
        for (var item in dummyCopy) {
          if (item.name!.contains(query)) {
            dummyListData.add(item);
          }
        }
        setState(() {
          controller.departaments.clear();
          controller.departaments.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          controller.departaments.clear();
          controller.departaments.addAll(copy);
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
                              'Insira o nome do departamento',
                              const Icon(Icons.search)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      controller.departaments.isNotEmpty
                          ? Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  _handleDepartaments();
                                },
                                child: ListView.builder(
                                  itemCount: controller.departaments.length,
                                  itemBuilder: (ctx, i) => Column(
                                    children: <Widget>[
                                      getCardDepartament(
                                          controller.departaments[i]),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Nenhum departamento encontrado',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ));
    });
  }
}
