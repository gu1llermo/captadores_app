import 'package:flutter/material.dart';

import '../../../shared/inputs/input_form.dart';


class RepeatPassword extends InputForm<String, RepeatPassword> {
  final TextEditingController? controller;
  final String password;

  const RepeatPassword({
    required super.value,
    super.hasError,
    this.controller,
    required this.password,
  });

  @override
  RepeatPassword copyWith({
    String? value,
    bool? hasError,
    TextEditingController? controller,
    String? password,
  }) {
    return RepeatPassword(
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
      controller: controller ?? this.controller,
      password: password ?? this.password,
    );
  }

  @override
  String? get errorMessage {
    if (value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    if (value != password) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}