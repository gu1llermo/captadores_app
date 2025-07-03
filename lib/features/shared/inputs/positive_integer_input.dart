import 'input_form.dart';

class PositiveIntegerInput extends InputForm<String, PositiveIntegerInput> {
  const PositiveIntegerInput({
    required super.value,
    super.hasError,
  });

  @override
  PositiveIntegerInput copyWith({
    String? value,
    bool? hasError,
  }) =>
      PositiveIntegerInput(
        value: value ?? this.value,
        hasError: hasError ?? this.hasError,
      );

  @override
  String? get errorMessage {
    final valor = value.trim();
    if (valor.isEmpty) return 'Campo obligatorio';
    int valueNumber = 0;
    try {
      valueNumber = int.parse(valor);
    } catch (e) {
      return 'Formato incorrecto';
    }

    if (valueNumber <= 0) return 'Debe ser > 0';

    return null;
  }
}
