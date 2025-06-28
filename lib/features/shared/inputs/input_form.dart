abstract class InputForm<T, R extends InputForm<T, R>> {
  final T value;
  final bool hasError;

  const InputForm({
    required this.value,
    this.hasError = false,
  });

  String? get errorMessage;

  R onChanged(T value) {
    if (!hasError) {
      return this.copyWith(value: value); // si no hay error simplemente regresa
    }
    // una nueva instancia con el valor
    if (errorMessage == null) {
      // quiere decir que se quitó el error
      return this.copyWith(value: value, hasError: false);
    }
    // si no se quitó el error, regresa la instancia actual con el valor
    return this.copyWith(value: value);
  }

  R validate() {
    if (errorMessage != null) {
      return this.copyWith(hasError: true);
    } else {
      return this.copyWith(hasError: false);
    }
  }

  R copyWith({T? value, bool? hasError});
}
