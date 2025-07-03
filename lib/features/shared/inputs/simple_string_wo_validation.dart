import 'package:flutter/material.dart';

import 'input_form.dart';

class SimpleStringWOValidation extends InputForm<String, SimpleStringWOValidation> {
  final TextEditingController controller;
  const SimpleStringWOValidation({
    required super.value,
    super.hasError,
    required this.controller,
  });

  @override
  SimpleStringWOValidation copyWith({
    String? value,
    bool? hasError,
    TextEditingController? controller,
  }) {
    return SimpleStringWOValidation(
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
      controller: controller ?? this.controller,
    );
  }

  @override
  String? get errorMessage {
    // sin validación
    return null;
  }
}
