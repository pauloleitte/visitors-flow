// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VisitorController on _VisitorControllerBase, Store {
  Computed<VisitorViewModel>? _$modelComputed;

  @override
  VisitorViewModel get model =>
      (_$modelComputed ??= Computed<VisitorViewModel>(() => super.model,
              name: '_VisitorControllerBase.model'))
          .value;

  late final _$idAtom =
      Atom(name: '_VisitorControllerBase.id', context: context);

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_VisitorControllerBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_VisitorControllerBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$telephoneAtom =
      Atom(name: '_VisitorControllerBase.telephone', context: context);

  @override
  String? get telephone {
    _$telephoneAtom.reportRead();
    return super.telephone;
  }

  @override
  set telephone(String? value) {
    _$telephoneAtom.reportWrite(value, super.telephone, () {
      super.telephone = value;
    });
  }

  late final _$isChurchgoerAtom =
      Atom(name: '_VisitorControllerBase.isChurchgoer', context: context);

  @override
  bool? get isChurchgoer {
    _$isChurchgoerAtom.reportRead();
    return super.isChurchgoer;
  }

  @override
  set isChurchgoer(bool? value) {
    _$isChurchgoerAtom.reportWrite(value, super.isChurchgoer, () {
      super.isChurchgoer = value;
    });
  }

  late final _$churchAtom =
      Atom(name: '_VisitorControllerBase.church', context: context);

  @override
  String? get church {
    _$churchAtom.reportRead();
    return super.church;
  }

  @override
  set church(String? value) {
    _$churchAtom.reportWrite(value, super.church, () {
      super.church = value;
    });
  }

  late final _$observationsAtom =
      Atom(name: '_VisitorControllerBase.observations', context: context);

  @override
  String? get observations {
    _$observationsAtom.reportRead();
    return super.observations;
  }

  @override
  set observations(String? value) {
    _$observationsAtom.reportWrite(value, super.observations, () {
      super.observations = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_VisitorControllerBase.busy', context: context);

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
name: ${name},
email: ${email},
telephone: ${telephone},
isChurchgoer: ${isChurchgoer},
church: ${church},
observations: ${observations},
busy: ${busy},
model: ${model}
    ''';
  }
}
