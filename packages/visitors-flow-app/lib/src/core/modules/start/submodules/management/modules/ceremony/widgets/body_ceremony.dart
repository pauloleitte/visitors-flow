import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';

class BodyCeremony extends StatefulWidget {
  const BodyCeremony({Key? key}) : super(key: key);

  @override
  State<BodyCeremony> createState() => _BodyCeremonyState();
}

class _BodyCeremonyState
    extends ModularState<BodyCeremony, CeremonyController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  List<CeremonyModel> copy = [];

  @override
  void initState() {
    super.initState();
    _handleCeremonies();
  }

  _handleCeremonies() async {
    await controller.getCeremonies();
    copy.addAll(controller.ceremonies);
  }

  Widget getCardCeremony(CeremonyModel ceremony) {
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
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.CEREMONY_DETAIL, arguments: ceremony);
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

  filterSearchResults(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      List<CeremonyModel> dummyCeremoniesCopy = [];
      dummyCeremoniesCopy.addAll(controller.ceremonies);
      if (query.isNotEmpty) {
        List<CeremonyModel> dummyListData = [];
        for (var item in dummyCeremoniesCopy) {
          if (item.name!.contains(query)) {
            dummyListData.add(item);
          }
        }
        setState(() {
          controller.ceremonies.clear();
          controller.ceremonies.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          controller.ceremonies.clear();
          controller.ceremonies.addAll(copy);
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
                              'Insira o nome do culto',
                              const Icon(Icons.search)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      controller.ceremonies.isNotEmpty
                          ? Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  _handleCeremonies();
                                },
                                child: ListView.builder(
                                  itemCount: controller.ceremonies.length,
                                  itemBuilder: (ctx, i) => Column(
                                    children: <Widget>[
                                      getCardCeremony(controller.ceremonies[i]),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Nenhum culto encontrado',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ));
    });
  }
}
