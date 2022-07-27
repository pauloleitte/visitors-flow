import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/base_app_bar_wiget.dart';

class CeremonyFormPage extends StatefulWidget {
  const CeremonyFormPage({Key? key}) : super(key: key);

  @override
  State<CeremonyFormPage> createState() => _CeremonyFormPageState();
}

class _CeremonyFormPageState extends State<CeremonyFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: 'Cadastro de Culto'),
      body: Container(),
    );
  }
}
