// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departament_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepartamentController on _DepartamentControllerBase, Store {
  Computed<DepartamentViewModel>? _$modelComputed;

  @override
  DepartamentViewModel get model =>
      (_$modelComputed ??= Computed<DepartamentViewModel>(() => super.model,
              name: '_DepartamentControllerBase.model'))
          .value;

  late final _$departamentAtom =
      Atom(name: '_DepartamentControllerBase.departament', context: context);

  @override
  DepartamentModel get departament {
    _$departamentAtom.reportRead();
    return super.departament;
  }

  @override
  set departament(DepartamentModel value) {
    _$departamentAtom.reportWrite(value, super.departament, () {
      super.departament = value;
    });
  }

  late final _$membersAtom =
      Atom(name: '_DepartamentControllerBase.members', context: context);

  @override
  List<MemberModel> get members {
    _$membersAtom.reportRead();
    return super.members;
  }

  @override
  set members(List<MemberModel> value) {
    _$membersAtom.reportWrite(value, super.members, () {
      super.members = value;
    });
  }

  late final _$noticesAtom =
      Atom(name: '_DepartamentControllerBase.notices', context: context);

  @override
  List<NoticeModel> get notices {
    _$noticesAtom.reportRead();
    return super.notices;
  }

  @override
  set notices(List<NoticeModel> value) {
    _$noticesAtom.reportWrite(value, super.notices, () {
      super.notices = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_DepartamentControllerBase.busy', context: context);

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

  late final _$departamentsAtom =
      Atom(name: '_DepartamentControllerBase.departaments', context: context);

  @override
  List<DepartamentModel> get departaments {
    _$departamentsAtom.reportRead();
    return super.departaments;
  }

  @override
  set departaments(List<DepartamentModel> value) {
    _$departamentsAtom.reportWrite(value, super.departaments, () {
      super.departaments = value;
    });
  }

  @override
  String toString() {
    return '''
departament: ${departament},
members: ${members},
notices: ${notices},
busy: ${busy},
departaments: ${departaments},
model: ${model}
    ''';
  }
}
