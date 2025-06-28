import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/mixins/debounce_mixin.dart';
import '../inputs/inputs.dart';
import 'auth_provider.dart';

part 'login_provider.g.dart';

@Riverpod(dependencies: [AuthNotifier])
class LoginNotifier extends _$LoginNotifier with DebounceMixin {
  @override
  LoginState build() {
    ref.onDispose(() {
      cancelAllDebouncers();
    });
    return  LoginState(
      email: Email(value: '', controller: TextEditingController()),
      password: Password(value: '', controller: TextEditingController()),
    );
  }

  Future<void> updateEmailWithDebounce(String value) async {
    debounce('email', () {
       onEmailChanged(value);
    },);
  }

  void onEmailChanged(String value) {
    final emailChanged = state.email.onChanged(value);
    state = state.copyWith(email: emailChanged);
  }

  void onEmailValidate() {
    final emailValidated = state.email.validate();
    state = state.copyWith(email: emailValidated);
  }

  Future<void> updatePasswordWithDebounce(String value) async {
    debounce('password', () {
      onPasswordChanged(value);
    },);
  }

  void onPasswordChanged(String value) {
    final passwordChanged = state.password.onChanged(value);
    state = state.copyWith(password: passwordChanged);
  }

  void onPasswordValidate() {
    final passwordValidated = state.password.validate();
    state = state.copyWith(password: passwordValidated);
  }

  Future<void> validateInputs() async {
    if (isDebounceActive('email') || isDebounceActive('password')) {
      await Future.delayed(defaultDurationDebouncers);
    }
    onEmailValidate();
    onPasswordValidate();
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true);
    await validateInputs();
    if (!state.isValidForm) {
      state = state.copyWith(isLoading: false);
      return;
      }
    try {
      await ref.read(authNotifierProvider.notifier).login(
        email: state.email.value.trim(),
        password: state.password.value,
      );
    } catch (e) {
      await setError(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

// tienes que hacer asi con el error para que se actualice
// el estado en caso de errores, porque sino lo cambias
// no se fefleja correctamente en el cambio de estados
  Future<void> setError(String error) async {
    state = state.copyWith(errorMessage: error, isLoading: false);
    await Future.delayed(const Duration(seconds: 3));
    state = state.copyWith(errorMessage: '');
  }

  void toggleObscureText() {
    state = state.copyWith(obscureText: !state.obscureText);
  }
}

class LoginState {
  final Email email;
  final Password password;
  final bool _isLoading;
  final String _errorMessage;
  final bool obscureText;

  const LoginState({
    this.email = const Email(value: ''),
    this.password = const Password(value: ''),
    bool? isLoading,
    String? errorMessage,
    this.obscureText = true,
  }) : _isLoading = isLoading ?? false,
       _errorMessage = errorMessage ?? '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  // si alguna entrada tiene error, entonces no es válido el formulario
  bool get isValidForm => ![email.hasError, password.hasError].any((input) => input);

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? isLoading,
    String? errorMessage,
    bool? obscureText,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
 
