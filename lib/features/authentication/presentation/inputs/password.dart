import 'package:flutter/material.dart';

import '../../../shared/inputs/input_form.dart';

class Password extends InputForm<String, Password> {
  final TextEditingController? controller;
  const Password({
    required super.value,
    super.hasError,
    this.controller,
  });

  @override
  Password copyWith({
    String? value,
    bool? hasError,
    TextEditingController? controller,
  }) {
    return Password(
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
      controller: controller ?? this.controller,
    );
  }

  @override
  String? get errorMessage {
    if (value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }
}

