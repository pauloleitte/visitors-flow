import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/widgets/title_widget.dart';
import '../controllers/notice_controller.dart';
import 'notice_item.dart';

class BodyNotice extends StatefulWidget {
  const BodyNotice({Key? key}) : super(key: key);

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
      return SafeArea(
        child: controller.busy
            ? const Center(child: CircularProgressIndicator())
            : controller.notices.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        buildTitle(title: 'Avisos'),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
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
