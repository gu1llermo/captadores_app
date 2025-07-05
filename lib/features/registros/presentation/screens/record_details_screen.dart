import 'package:captadores_app/core/extensions/datetime_utils_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/url_launcher/providers/providers.dart';
import '../providers/registros_provider.dart';

class RecordDetailsScreen extends ConsumerWidget {
  const RecordDetailsScreen({super.key, required this.idRegistro});
  final String idRegistro;

  // String? encodeQueryParameters(Map<String, String> params) {
  //   return params.entries
  //       .map(
  //         (MapEntry<String, String> e) =>
  //             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
  //       )
  //       .join('&');
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosProvider = ref.watch(registrosNotifierProvider);
    return registrosProvider.when(
      data: (RegistrosState state) {
        final registro = state.getRecordById(idRegistro);
        return Scaffold(
          appBar: AppBar(title: const Text('Detalle')),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _TitleViewWidget(
                title: 'Fecha ingreso datos:',
                data: registro?.fechaIngresoDatos.getFormat01() ?? '',
              ),
              _TitleViewWidget(
                title: 'Nombre Cliente:',
                data: '${registro?.nombreCompletoCliente}',
              ),
              _TitleViewWidget(
                title: 'Fono de contacto:',
                data: '${registro?.fonoContactoCliente}',
                onTap: () {
                  if (registro?.fonoContactoCliente == null) return;

                  final launcherService = ref.read(urlLauncherServiceProvider);
                  final celular = registro!.fonoContactoCliente;
                  final mensaje = 'Saludos';

                  launcherService
                      .abrirWhatsApp(telefono: celular, mensaje: mensaje)
                      .onError((error, stackTrace) {
                        // muestra un snackBar con el error
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      });
                },
              ),
              _TitleViewWidget(
                title: 'Email:',
                data: '${registro?.emailCliente}',
                onTap: () async {
                  if (registro?.emailCliente == null ||
                      registro?.emailCliente == '') {
                    return;
                  }
                  final email = registro!.emailCliente!;

                  final launcherService = ref.read(urlLauncherServiceProvider);

                  launcherService
                      .sendEmail(email: email)
                      .onError((error, stackTrace) {
                        // muestra un snackBar con el error
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      });


                  // final Uri emailLaunchUri = Uri(
                  //   scheme: 'mailto',
                  //   path: email,
                  //   // query: encodeQueryParameters(<String, String>{
                  //   //   'subject': 'Example Subject & Symbols are allowed!',
                  //   // }),
                  // );
                  // try {
                  //   await launchUrl(emailLaunchUri);
                  // } catch (error, stackTrace) {
                  //   debugPrint('Error: $error, $stackTrace');
                  //   if (!context.mounted) return;
                  //   ScaffoldMessenger.of(
                  //     context,
                  //   ).showSnackBar(SnackBar(content: Text(error.toString())));
                  // }

                },
              ),

              _TitleViewWidget(
                title: 'Rut Cliente:',
                data: registro?.rutCliente ?? '',
              ),
              _TitleViewWidget(title: 'Dni:', data: '${registro?.dniExt}'),
              _TitleViewWidget(
                title: 'Cierre en 1era cita:',
                data: registro?.cierre1eraCita ?? '',
              ),
              _TitleViewWidget(
                title: 'Fecha 2do llamado:',
                data: registro?.fecha2doLlamado?.getFormat01() ?? '',
              ),
              _TitleViewWidget(
                title: '2do llamado:',
                data: registro?.segundoLlamado ?? '',
              ),
              _TitleViewWidget(
                title: 'Fecha segunda cita:',
                data: registro?.fechaSegundaCita?.getFormat01() ?? '',
              ),
              _TitleViewWidget(
                title: 'Cierre en segunda cita:',
                data: registro?.cierreEn2daCita ?? '',
              ),
              _TitleViewWidget(
                title: 'Fecha 3er llamado:',
                data: registro?.fecha3erLlamado?.getFormat01() ?? '',
              ),
              _TitleViewWidget(
                title: 'Tercer llamado:',
                data: registro?.tercerLlamado ?? '',
              ),
              _TitleViewWidget(
                title: 'Fecha 3era cita:',
                data: registro?.fechaTerceraCita?.getFormat01() ?? '',
              ),
              _TitleViewWidget(
                title: 'Cierre en 3era cita:',
                data: registro?.cierreEn3eraCita ?? '',
              ),
              _TitleViewWidget(
                title: 'Fecha de cierre:',
                data: registro?.fechaDeCierre?.getFormat01() ?? '',
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(child: Text('$error, $stackTrace')),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }
}

class _TitleViewWidget extends StatelessWidget {
  const _TitleViewWidget({required this.title, required this.data, this.onTap});
  final String title;
  final String data;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(title, style: textStyle),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: InkWell(
                onTap: onTap,
                child: Text(data, style: textStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
