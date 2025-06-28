import 'package:flutter/material.dart';

import '../../../shared/inputs/input_form.dart';


// expresión regular para validar emails
final RegExp _emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

class Email extends InputForm<String, Email> {
  final TextEditingController? controller;

  const Email({
    required super.value,
    super.hasError,
    this.controller,
  });

  @override
  Email copyWith({
    String? value,
    bool? hasError,
    TextEditingController? controller,
  }) {
    return Email(
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
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Formato de email inválido';
    }
    return null;
  }
}
