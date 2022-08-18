import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/notice_controller.dart';
import 'notice_item.dart';

class BodyNotice extends StatefulWidget {
  BodyNotice({Key? key}) : super(key: key);

  @override
  State<BodyNotice> createState() => _BodyNoticeState();
}

class _BodyNoticeState extends ModularState<BodyNotice, NoticeController> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await controller.getNotices();
  }

  _handleCeremonies() async {
    await controller.getNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Stack(
        children: [
          controller.busy
              ? const Center(child: CircularProgressIndicator())
              : controller.notices.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _handleCeremonies();
                        },
                        child: ListView.builder(
                          itemCount: controller.notices.length,
                          itemBuilder: (ctx, i) => Column(
                            children: <Widget>[
                              NoticeItem(controller.notices[i]),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Nenhum aviso cadastrado',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
        ],
      );
    });
  }
}
