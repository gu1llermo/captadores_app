import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/mixins/debounce_mixin.dart';
import '../../../shared/inputs/email.dart';
import 'auth_provider.dart';

part 'recovery_password_provider.g.dart';

class RecoveryPasswordState {
  final Email email;
  final bool isLoading;
  final String statusMessage;

  const RecoveryPasswordState({
    required this.email,
    this.isLoading = false,
    this.statusMessage = '',
  });
  
  RecoveryPasswordState copyWith({
    Email? email,
    bool? isLoading,
    String? statusMessage,
  }) {
    return RecoveryPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  bool get isValidForm => !email.hasError;
}

@Riverpod(dependencies: [AuthNotifier])
class RecoveryPasswordNotifier extends _$RecoveryPasswordNotifier with DebounceMixin {
  late TextEditingController _emailController;
  @override
  RecoveryPasswordState build() {
    _emailController = TextEditingController();
    ref.onDispose(() {
      _emailController.dispose();
      cancelAllDebouncers();
    });
    return  RecoveryPasswordState(
      email: Email(value: '', controller: _emailController),
    );
  }

  void updateEmailWithDebounce(String value) {
    debounce(
      'email',
      () => updateEmail(value),
      // duration: const Duration(milliseconds: 500),
    );
  }

  void updateEmail(String value) {
    final emailChanged = state.email.onChanged(value);
    state = state.copyWith(email: emailChanged);
  }
  void validateEmail(){
    final emailValidated = state.email.validate();
    state = state.copyWith(email: emailValidated);
  }

  void validateInputs() {
    validateEmail();
  }

  Future<void> recoveryPassword() async {
    validateInputs();
    if (!state.isValidForm) return;
    
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(authNotifierProvider.notifier).recoveryPassword(
        email: state.email.value.trim(),
      );
      state = state.copyWith(email: state.email.copyWith(value: ''));
      await showMessage('Revise su correo electrónico');
    } catch (e) {
      await showMessage(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
  
  Future<void> showMessage(String message) async {
    state = state.copyWith(statusMessage: message, isLoading: false);
    await Future.delayed(const Duration(seconds: 3));
    state = state.copyWith(statusMessage: '');
  }
  
}
  