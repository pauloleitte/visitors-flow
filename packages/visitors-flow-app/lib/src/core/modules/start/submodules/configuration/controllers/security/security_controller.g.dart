// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SecurityController on _SecurityControllerBase, Store {
  Computed<UserUpdatePasswordViewModel>? _$vmPasswordComputed;

  @override
  UserUpdatePasswordViewModel get vmPassword => (_$vmPasswordComputed ??=
          Computed<UserUpdatePasswordViewModel>(() => super.vmPassword,
              name: '_SecurityControllerBase.vmPassword'))
      .value;

  late final _$modelAtom =
      Atom(name: '_SecurityControllerBase.model', context: context);

  @override
  UserModel get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(UserModel value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_SecurityControllerBase.busy', context: context);

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
model: ${model},
busy: ${busy},
vmPassword: ${vmPassword}
    ''';
  }
}
