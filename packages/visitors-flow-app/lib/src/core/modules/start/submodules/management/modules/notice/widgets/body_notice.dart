import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../config/app_routes.dart';
import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';

class BodyNotice extends StatefulWidget {
  const BodyNotice({Key? key}) : super(key: key);

  @override
  State<BodyNotice> createState() => _BodyNoticeState();
}

class _BodyNoticeState extends ModularState<BodyNotice, NoticeController> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getNotices();
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
          Modular.to.navigate(AppRoutes.NOTICE_FORM, arguments: notice);
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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: controller.busy
            ? const Center(child: CircularProgressIndicator())
            : controller.notices.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
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
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      'Nenhum aviso cadastrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
      );
    });
  }
}
