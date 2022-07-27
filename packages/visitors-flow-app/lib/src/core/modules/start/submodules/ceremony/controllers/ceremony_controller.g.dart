// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ceremony_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CeremonyController on _CeremonyControllerBase, Store {
  Computed<CeremonyViewModel>? _$modelComputed;

  @override
  CeremonyViewModel get model =>
      (_$modelComputed ??= Computed<CeremonyViewModel>(() => super.model,
              name: '_CeremonyControllerBase.model'))
          .value;

  late final _$nameAtom =
      Atom(name: '_CeremonyControllerBase.name', context: context);

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

  late final _$descriptionAtom =
      Atom(name: '_CeremonyControllerBase.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$dateAtom =
      Atom(name: '_CeremonyControllerBase.date', context: context);

  @override
  String? get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String? value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$idAtom =
      Atom(name: '_CeremonyControllerBase.id', context: context);

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

  late final _$busyAtom =
      Atom(name: '_CeremonyControllerBase.busy', context: context);

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
name: ${name},
description: ${description},
date: ${date},
id: ${id},
busy: ${busy},
model: ${model}
    ''';
  }
}
