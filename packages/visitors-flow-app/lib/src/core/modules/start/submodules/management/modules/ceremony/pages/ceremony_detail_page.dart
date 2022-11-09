import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../models/ceremony_model.dart';

class CeremonyDetailPage extends StatefulWidget {
  final CeremonyModel? ceremony;
  const CeremonyDetailPage({super.key, this.ceremony});

  @override
  State<CeremonyDetailPage> createState() => _CeremonyDetailPageState();
}

class _CeremonyDetailPageState extends State<CeremonyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.ceremony!.name!),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.CEREMONY),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => {
                Modular.to.pushNamed(AppRoutes.CEREMONY_FORM,
                    arguments: widget.ceremony)
              },
            ),
          ]),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Text(widget.ceremony!.name!,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                Text(widget.ceremony!.description!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                Text(DateFormat('dd/MM/yyyy').format(widget.ceremony!.date!),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 50.0),
                Text("Avisos",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 20.0),
                widget.ceremony!.notices != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.ceremony!.notices!.length,
                          itemBuilder: (context, index) {
                            final notice = widget.ceremony!.notices![index];
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                title: Text(
                                  notice.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.NOTICE_DETAIL,
                                      arguments: notice);
                                },
                                subtitle: Text(
                                  notice.description!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text("Nenhum Aviso"),
                const SizedBox(height: 20.0),
                Text("Visitantes",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 20.0),
                widget.ceremony!.visitors != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.ceremony!.visitors!.length,
                          itemBuilder: (context, index) {
                            final visitor = widget.ceremony!.visitors![index];
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                title: Text(
                                  visitor.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.VISITOR_DETAIL,
                                      arguments: visitor);
                                },
                                subtitle: Text(
                                  visitor.email!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text("Nenhum Visitante"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
