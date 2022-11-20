import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/member_controller.dart';
import '../models/member_model.dart';

class BodyMember extends StatefulWidget {
  const BodyMember({Key? key}) : super(key: key);

  @override
  State<BodyMember> createState() => _BodyMemberState();
}

class _BodyMemberState extends ModularState<BodyMember, MemberController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  List<MemberModel> copy = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getMembers();
    copy.addAll(controller.members);
  }

  _handleCeremonies() async {
    await controller.getMembers();
  }

  Widget getCardMember(MemberModel member) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.people,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          member.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.MEMBER_DETAIL, arguments: member);
        },
        subtitle: Text(
          '${member.job}',
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
      List<MemberModel> dummyMembersCopy = [];
      dummyMembersCopy.addAll(controller.members);
      if (query.isNotEmpty) {
        List<MemberModel> dummyListData = [];
        for (var item in dummyMembersCopy) {
          if (item.name!.contains(query)) {
            dummyListData.add(item);
          }
        }
        setState(() {
          controller.members.clear();
          controller.members.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          controller.members.clear();
          controller.members.addAll(copy);
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
                            'Insira o nome do membro',
                            const Icon(Icons.search)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    controller.members.isNotEmpty
                        ? Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                _handleCeremonies();
                              },
                              child: ListView.builder(
                                itemCount: controller.members.length,
                                itemBuilder: (ctx, i) => Column(
                                  children: <Widget>[
                                    getCardMember(controller.members[i]),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                            'Nenhum membro encontrado!',
                            style: TextStyle(fontSize: 20),
                          )),
                  ],
                ),
              ),
      );
    });
  }
}
