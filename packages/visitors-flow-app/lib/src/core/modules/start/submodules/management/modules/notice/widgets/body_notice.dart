import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';

class BodyNotice extends StatefulWidget {
  const BodyNotice({Key? key}) : super(key: key);

  @override
  State<BodyNotice> createState() => _BodyNoticeState();
}

class _BodyNoticeState extends ModularState<BodyNotice, NoticeController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  List<NoticeModel> copy = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getNotices();
    copy.addAll(controller.notices);
  }

  _handleCeremonies() async {
    await controller.getNotices();
  }

  Widget getCardNotice(NoticeModel notice) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          notice.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.NOTICE_DETAIL, arguments: notice);
        },
        subtitle: Text(
          '${notice.description}',
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
      List<NoticeModel> dummyCopy = [];
      dummyCopy.addAll(controller.notices);
      if (query.isNotEmpty) {
        List<NoticeModel> dummyListData = [];
        for (var item in dummyCopy) {
          if (item.name!.contains(query)) {
            dummyListData.add(item);
          }
        }
        setState(() {
          controller.notices.clear();
          controller.notices.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          controller.notices.clear();
          controller.notices.addAll(copy);
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
                              'Insira o nome do aviso',
                              const Icon(Icons.search)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      controller.notices.isNotEmpty
                          ? Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  _handleCeremonies();
                                },
                                child: ListView.builder(
                                  itemCount: controller.notices.length,
                                  itemBuilder: (ctx, i) => Column(
                                    children: <Widget>[
                                      getCardNotice(controller.notices[i]),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Nenhum aviso encontrado',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ));
    });
  }
}
