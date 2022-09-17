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

  late final _$visitorAtom =
      Atom(name: '_VisitorControllerBase.visitor', context: context);

  @override
  VisitorModel get visitor {
    _$visitorAtom.reportRead();
    return super.visitor;
  }

  @override
  set visitor(VisitorModel value) {
    _$visitorAtom.reportWrite(value, super.visitor, () {
      super.visitor = value;
    });
  }

  late final _$visitorsAtom =
      Atom(name: '_VisitorControllerBase.visitors', context: context);

  @override
  List<VisitorModel> get visitors {
    _$visitorsAtom.reportRead();
    return super.visitors;
  }

  @override
  set visitors(List<VisitorModel> value) {
    _$visitorsAtom.reportWrite(value, super.visitors, () {
      super.visitors = value;
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

  late final _$filterAtom =
      Atom(name: '_VisitorControllerBase.filter', context: context);

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  @override
  String toString() {
    return '''
visitor: ${visitor},
visitors: ${visitors},
busy: ${busy},
filter: ${filter},
model: ${model}
    ''';
  }
}
