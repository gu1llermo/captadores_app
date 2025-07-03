import 'package:flutter/material.dart';

import 'input_form.dart';

class NumInput extends InputForm<String, NumInput> {
  final TextEditingController controller;
  const NumInput({
    required super.value,
    super.hasError,
    required this.controller,
  });
  @override
  NumInput copyWith({
    String? value,
    bool? hasError,
    TextEditingController? controller,
  }) {
    return NumInput(
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
      controller: controller ?? this.controller,
    );
  }

  @override
  String? get errorMessage {
    final valueTrim = value.trim();
    if (valueTrim.isEmpty) {
      return 'Campo obligatorio';
    }
    final numValue = num.tryParse(valueTrim);
    if (numValue == null) {
      return 'Debe ser un número';
    }
    if (numValue <= 0) {
      return 'Debe ser mayor que 0';
    }

    return null;
  }
}
