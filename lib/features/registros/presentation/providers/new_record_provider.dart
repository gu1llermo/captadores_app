import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/environment_config.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../shared/inputs/inputs.dart';
import '../../domain/entities/registro_entity.dart';
import 'registros_provider.dart';
import 'registros_repository_provider.dart';

part 'new_record_provider.g.dart';

@Riverpod(dependencies: [registrosRepository, AuthNotifier, RegistrosNotifier])
class NewRecordNotifier extends _$NewRecordNotifier {
  AsyncValue<AuthState>? _authStateAsync;

  TextEditingController? _controllerNombreCompletoCliente;
  TextEditingController? _controllerFonoContactoCliente;
  TextEditingController? _controllerAbogadoQueRecepciona;
  TextEditingController? _controllerRutCliente;
  TextEditingController? _controllerDniExt;
  TextEditingController? _controllerEmailCliente;
  
  final _databaseUrl = EnvironmentConfig().databaseUrl;

  @override
  Future<NewRecordState> build() async {
    _authStateAsync = ref.watch(authNotifierProvider);

    List<String> abogados = [];
    try {
      abogados = await getAbogados();
    } catch (error, stackTrace) {
      debugPrint('Error: $error, $stackTrace');
      // await setError(error: error, stackTrace:stackTrace, currentState: currentState);
    }

    // List<TextEditingController?> controllers = [
    //   _controllerNombreCompletoCliente,
    //   _controllerFonoContactoCliente,
    //   _controllerAbogadoQueRecepciona,
    //   _controllerRutCliente,
    //   _controllerDniExt,
    //   _controllerEmailCliente,
    // ];

    // controllers.map((controller) => controller = TextEditingController());

    _controllerNombreCompletoCliente = TextEditingController();
    _controllerFonoContactoCliente = TextEditingController();

    _controllerAbogadoQueRecepciona = TextEditingController();
    _controllerRutCliente = TextEditingController();
    _controllerDniExt = TextEditingController();
    _controllerEmailCliente = TextEditingController();

    // _controllerComboWidget = TextEditingController();

    ref.onDispose(() {
      // controllers.map((controller) => controller?.dispose());

      _controllerNombreCompletoCliente?.dispose();
      _controllerFonoContactoCliente?.dispose();

      _controllerAbogadoQueRecepciona?.dispose();
      _controllerRutCliente?.dispose();
      _controllerDniExt?.dispose();
      _controllerEmailCliente?.dispose();

      // _controllerComboWidget?.dispose();
    });

    return NewRecordState(
      abogados: abogados,
      nombreCompletoCliente: SimpleString(
        value: '',
        controller: _controllerNombreCompletoCliente!,
      ),
      fonoContactoCliente: NumInput(
        value: '',
        controller: _controllerFonoContactoCliente!,
      ),
      abogadoQueRecepciona: SimpleStringWOValidation(
        value: '',
        controller: _controllerAbogadoQueRecepciona!,
      ),
      rutCliente: SimpleStringWOValidation(
        value: '',
        controller: _controllerRutCliente!,
      ),
      dniExt: SimpleStringWOValidation(
        value: '',
        controller: _controllerDniExt!,
      ),
      emailCliente: SimpleStringWOValidation(
        value: '',
        controller: _controllerEmailCliente!,
      ),
      // controllerComboWidget: _controllerComboWidget!,
    );
  }

  bool isAuthenticated() {
    if (_authStateAsync == null) return false;
    if (_authStateAsync!.hasValue) {
      final authState = _authStateAsync!.value!;
      if (authState.isAutenticated) {
        return true;
      }
    }
    return false;
  }

  Future<List<String>> getAbogados() async {
    
    

      final abogados = await ref
          .read(registrosRepositoryProvider)
          .getAbogadosName(apiBaseUrl: _databaseUrl);

      return abogados;
    
    
  }
  // Future<List<String>> getAbogados() async {

  //   if (_authStateAsync == null) return [];
  //   if (_authStateAsync!.hasValue) {
  //     final authState = _authStateAsync!.value!;
  //     if (authState.isAutenticated) {
  //       final user = authState.user!;

  //       final abogados = await ref
  //           .read(registrosRepositoryProvider)
  //           .getAbogadosName(apiBaseUrl: user.apiBaseUrl);

  //       return abogados;
  //     }
  //   }

  //   return [];
  // }

  // valida nombre de cliente
  Future<void> onNombreCompletoClienteValidate() async {
    final currentState = await future;
    final nombreCompletoCliente = currentState.nombreCompletoCliente;
    final value = nombreCompletoCliente.controller.text;
    final nombreCompletoClienteValidated = nombreCompletoCliente
        .onChanged(value)
        .validate();
    state = AsyncData(
      currentState.copyWith(
        nombreCompletoCliente: nombreCompletoClienteValidated,
      ),
    );
  }

  Future<void> onFonoContactoClienteValidate() async {
    final currentState = await future;
    final fonoContactoCliente = currentState.fonoContactoCliente;
    final value = fonoContactoCliente.controller.text;
    final fonoContactoClienteValidated = fonoContactoCliente
        .onChanged(value)
        .validate();
    state = AsyncData(
      currentState.copyWith(fonoContactoCliente: fonoContactoClienteValidated),
    );
  }

  Future<void> validateInputs() async {
    await onNombreCompletoClienteValidate();
    await onFonoContactoClienteValidate();
  }

  Future<bool> onFormSubmit() async {
    await validateInputs();
    final currentState = await future;
    if (!currentState.isValidForm) {
      return false;
    }
    // si llega aquí es válido
    // entonces mandamos a crear el registro
    try {
      if (isAuthenticated()) {
        state = const AsyncLoading();
        final authState = _authStateAsync!.value!;
        final user = authState.user!;

        final record = RegistroEntity(
          nombreAsesor: user.nombreAsesor,
          codigoAsesor: user.codigoAsesor,
          idRegistro: user.idNewRegistro,
          fechaIngresoDatos: DateTime.now(),
          nombreCompletoCliente: currentState.nombreCompletoCliente.value,
          fonoContactoCliente: currentState.fonoContactoCliente.value,

          abogadoQueRecepciona: currentState.abogadoQueRecepciona.controller.text,
          rutCliente: currentState.rutCliente.controller.text,
          dniExt: currentState.dniExt.controller.text,
          emailCliente: currentState.emailCliente.controller.text,
        );

       await ref
            .read(registrosNotifierProvider.notifier)
            .addNewRecord(
              sheetName: user.sheetName,
              apiBaseUrl: _databaseUrl,
              record: record,
            );

        state = AsyncData(currentState.copyWith());// con copywith para que sea un nuevo estado
        // aunque no hace falta porque cuando llegue aqui se vá a salir con pop
        // a la pantalla de registros

        return true;
      }
    } catch (error, stackTrace) {
      await setError(
        error: error,
        stackTrace: stackTrace,
        currentState: currentState,
      );
      return false;
    }

    // final campo = currentState.nombreCompletoCliente.controller.text;
    // print('campo= $campo');
    return false;
  }

  Future<void> setError({
    required Object error,
    required StackTrace stackTrace,
    required NewRecordState currentState,
  }) async {
    state = AsyncData(
      currentState.copyWith(
        statusMessage: 'Error: $error, $stackTrace',
        hasError: true,
      ),
    );
    await Future.delayed(const Duration(seconds: 3), () {
      state = AsyncData(
        currentState.copyWith(statusMessage: '', hasError: false),
      );
    });
  }
}

class NewRecordState {
  final bool hasError;
  final String statusMessage;

  // final bool isFormPosted;
  // final bool isPosting;

  final List<String> abogados;

  final SimpleString nombreCompletoCliente;
  final NumInput fonoContactoCliente;

  final SimpleStringWOValidation abogadoQueRecepciona;
  final SimpleStringWOValidation rutCliente;
  final SimpleStringWOValidation dniExt;
  final SimpleStringWOValidation emailCliente;

  // final TextEditingController controllerComboWidget;

  bool get isValidForm => ![
    nombreCompletoCliente.hasError,
    fonoContactoCliente.hasError,
  ].any((input) => input);

  NewRecordState({
    this.statusMessage = '',
    this.hasError = false,

    // this.isFormPosted = false,
    // this.isPosting = false,
    required this.abogados,
    required this.nombreCompletoCliente,
    required this.fonoContactoCliente,

    required this.abogadoQueRecepciona,
    required this.rutCliente,
    required this.dniExt,
    required this.emailCliente,

    // required this.controllerComboWidget,
  });

  NewRecordState copyWith({
    String? statusMessage,
    bool? hasError,

    // bool? isFormPosted,
    // bool? isPosting,
    List<String>? abogados,

    SimpleString? nombreCompletoCliente,
    NumInput? fonoContactoCliente,

    SimpleStringWOValidation? abogadoQueRecepciona,
    SimpleStringWOValidation? rutCliente,
    SimpleStringWOValidation? dniExt,
    SimpleStringWOValidation? emailCliente,

    // TextEditingController? controllerComboWidget,
  }) => NewRecordState(
    statusMessage: statusMessage ?? this.statusMessage,
    hasError: hasError ?? this.hasError,

    // isFormPosted: isFormPosted ?? this.isFormPosted,
    // isPosting: isPosting ?? this.isPosting,
    abogados: abogados ?? this.abogados,
    nombreCompletoCliente: nombreCompletoCliente ?? this.nombreCompletoCliente,
    fonoContactoCliente: fonoContactoCliente ?? this.fonoContactoCliente,
    abogadoQueRecepciona: abogadoQueRecepciona ?? this.abogadoQueRecepciona,
    rutCliente: rutCliente ?? this.rutCliente,
    dniExt: dniExt ?? this.dniExt,
    emailCliente: emailCliente ?? this.emailCliente,

    // controllerComboWidget: controllerComboWidget ?? this.controllerComboWidget,
  );
}
