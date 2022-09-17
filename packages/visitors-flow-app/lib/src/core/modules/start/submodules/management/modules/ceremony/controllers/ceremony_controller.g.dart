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

  late final _$ceremonyAtom =
      Atom(name: '_CeremonyControllerBase.ceremony', context: context);

  @override
  CeremonyModel get ceremony {
    _$ceremonyAtom.reportRead();
    return super.ceremony;
  }

  @override
  set ceremony(CeremonyModel value) {
    _$ceremonyAtom.reportWrite(value, super.ceremony, () {
      super.ceremony = value;
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

  late final _$ceremoniesAtom =
      Atom(name: '_CeremonyControllerBase.ceremonies', context: context);

  @override
  List<CeremonyModel> get ceremonies {
    _$ceremoniesAtom.reportRead();
    return super.ceremonies;
  }

  @override
  set ceremonies(List<CeremonyModel> value) {
    _$ceremoniesAtom.reportWrite(value, super.ceremonies, () {
      super.ceremonies = value;
    });
  }

  @override
  String toString() {
    return '''
ceremony: ${ceremony},
busy: ${busy},
ceremonies: ${ceremonies},
model: ${model}
    ''';
  }
}
