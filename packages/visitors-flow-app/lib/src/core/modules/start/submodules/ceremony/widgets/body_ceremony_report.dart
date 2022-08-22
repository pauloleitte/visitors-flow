import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import '../models/ceremony_model.dart';

class BodyCeremonyRerport extends StatefulWidget {
  final CeremonyModel ceremony;
  BodyCeremonyRerport({Key? key, required this.ceremony}) : super(key: key);

  @override
  State<BodyCeremonyRerport> createState() => _BodyCeremonyRerportState();
}

class _BodyCeremonyRerportState extends State<BodyCeremonyRerport> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                    child: ListTile(
                  title: Text(
                    widget.ceremony.name!,
                    style: TextStyle(fontSize: 30),
                  ),
                  subtitle: Text(
                    widget.ceremony.description!,
                    style: TextStyle(fontSize: 15),
                  ),
                )),
                widget.ceremony.visitors!.isEmpty
                    ? const Text('Nenhum visitante cadastrado')
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Card(
                          child: ListView.builder(
                            itemCount: widget.ceremony.visitors!.length,
                            itemBuilder: (ctx, i) => Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    Modular.to.pushNamed(AppRoutes.VISITOR_FORM,
                                        arguments:
                                            widget.ceremony.visitors![i]);
                                  },
                                  title:
                                      Text(widget.ceremony.visitors![i].name!),
                                  subtitle: Text(widget
                                      .ceremony.visitors![i].observations!),
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                widget.ceremony.notices!.isEmpty
                    ? const Text('Nenhum aviso cadastrado ')
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Card(
                          child: ListView.builder(
                            itemCount: widget.ceremony.notices!.length,
                            itemBuilder: (ctx, i) => Column(
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    Modular.to.pushNamed(AppRoutes.NOTICE_FORM,
                                        arguments: widget.ceremony.notices![i]);
                                  },
                                  title:
                                      Text(widget.ceremony.notices![i].name!),
                                  subtitle: Text(
                                      widget.ceremony.notices![i].description!),
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
