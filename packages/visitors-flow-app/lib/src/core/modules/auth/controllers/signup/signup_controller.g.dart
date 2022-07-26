// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupController on _SignupControllerBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_SignupControllerBase.isValid'))
      .value;
  Computed<bool>? _$isValidEmailComputed;

  @override
  bool get isValidEmail =>
      (_$isValidEmailComputed ??= Computed<bool>(() => super.isValidEmail,
              name: '_SignupControllerBase.isValidEmail'))
          .value;
  Computed<SignupViewModel>? _$modelComputed;

  @override
  SignupViewModel get model =>
      (_$modelComputed ??= Computed<SignupViewModel>(() => super.model,
              name: '_SignupControllerBase.model'))
          .value;

  late final _$nameAtom =
      Atom(name: '_SignupControllerBase.name', context: context);

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
      Atom(name: '_SignupControllerBase.email', context: context);

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

  late final _$passwordAtom =
      Atom(name: '_SignupControllerBase.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_SignupControllerBase.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_SignupControllerBase.busy', context: context);

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

  late final _$userCreateModelAtom =
      Atom(name: '_SignupControllerBase.userCreateModel', context: context);

  @override
  UserCreateModel? get userCreateModel {
    _$userCreateModelAtom.reportRead();
    return super.userCreateModel;
  }

  @override
  set userCreateModel(UserCreateModel? value) {
    _$userCreateModelAtom.reportWrite(value, super.userCreateModel, () {
      super.userCreateModel = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
password: ${password},
phone: ${phone},
busy: ${busy},
userCreateModel: ${userCreateModel},
isValid: ${isValid},
isValidEmail: ${isValidEmail},
model: ${model}
    ''';
  }
}
