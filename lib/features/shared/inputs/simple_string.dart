import 'package:flutter/material.dart';

import 'input_form.dart';

class SimpleString extends InputForm<String, SimpleString> {
  final TextEditingController controller;
  const SimpleString({
    required super.value,
    super.hasError,
    required this.controller,
  });

  @override
  SimpleString copyWith({
    String? value,
    bool? hasError,
    TextEditingController? controller,
  }) {
    return SimpleString(
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
    return null;
  }
}
