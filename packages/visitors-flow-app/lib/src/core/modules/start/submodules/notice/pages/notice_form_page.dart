import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../config/app_routes.dart';
import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';
import '../widgets/body_notice_form.dart';

class NoticeFormPage extends StatefulWidget {
  final NoticeModel? notice;
  const NoticeFormPage({Key? key, this.notice}) : super(key: key);

  @override
  State<NoticeFormPage> createState() => _NoticeFormPageState();
}

class _NoticeFormPageState
    extends ModularState<NoticeFormPage, NoticeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Aviso',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () => Modular.to.navigate(AppRoutes.NOTICE),
          ),
          actions: [
            ...(widget.notice?.name != null
                ? [
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).colorScheme.secondary),
                      onPressed: () async {
                        controller.notice = widget.notice!;
                        await controller.deleteNotice();
                        Modular.to.navigate(AppRoutes.NOTICE);
                      },
                    ),
                  ]
                : [])
          ]),
      body: BodyNoticeForm(notice: widget.notice),
    );
  }
}
