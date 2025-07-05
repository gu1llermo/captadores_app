import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:captadores_app/core/extensions/datetime_utils_extension.dart';
import 'package:captadores_app/core/extensions/strings_utils_extension.dart';
import 'package:captadores_app/features/registros/presentation/providers/registros_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/rutas.dart';
import '../../../../core/services/reload_page_service/providers/provider.dart';
import '../widgets/boton_animado.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/product_shimmer_list.dart';
import '../widgets/widgets.dart';

class RegistrosScreen extends ConsumerStatefulWidget {
  const RegistrosScreen({super.key});

  @override
  ConsumerState<RegistrosScreen> createState() => _RegistrosScreenState();
}

class _RegistrosScreenState extends ConsumerState<RegistrosScreen> {
  Future<void> onRefresh() async {
    await ref.read(registrosNotifierProvider.notifier).refreshFromServer();
    // if (kIsWeb) {
    //   await ref.read(reloadPageProvider).reloadPage();
    // } else {
    //   await ref.read(registrosNotifierProvider.notifier).refreshFromServer();
    // }
  }

  Future<void> onPressedCerrarSesion(BuildContext context) async {
    if (!context.mounted) return;

    // Mostrar diálogo de confirmación
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro que deseas cerrar la sesión?'),
        actions: [
          TextButton(
            onPressed: () async {
              context.pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.pop(); // Cerrar diálogo
              context.pop(); // Cerrar drawer
              await ref.read(registrosNotifierProvider.notifier).logout();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> onPressedAgregarRegistro(BuildContext context) async {
    saveScrollPosition();

    if (!context.mounted) return;

    await context.push(Rutas.newRecord).then((value) async {
      restoreScrollPosition();
      if (value is bool) {
        // entonces seguramente es un true
        if (!value) return; // para asegurarme de todas maneras
        ref
            .read(registrosNotifierProvider.notifier)
            .showMessage(message: 'Registro agregado exitosamente!');
      }
    });
  }

  // Before navigation
  void saveScrollPosition() {
    ref.read(registrosNotifierProvider.notifier).saveScrollPosition();
  }

  void restoreScrollPosition() {
    ref.read(registrosNotifierProvider.notifier).restoreScrollPosition();
  }

  ScrollController? getScrollController() {
    final registrosStateAsync = ref.read(registrosNotifierProvider);
    return registrosStateAsync.when(
      data: (state) {
        final isAuthenticated = ref
            .read(registrosNotifierProvider.notifier)
            .isAuthenticated();

        return isAuthenticated ? state.customScrollController : null;
      },
      error: (error, stackTrace) => null,
      loading: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final registrosStateAsync = ref.watch(registrosNotifierProvider);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: CustomDrawer(
        onPressedCerrarSesion: () => onPressedCerrarSesion(context),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //print('alto: ${constraints.maxHeight}');
          final alto = constraints.maxHeight;
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: getScrollController(),
            slivers: [
              SliverAppBar(
                title: const Text('Captadores DLC'),
                floating: true,
                snap: true,
                // expandedHeight: 50,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              registrosStateAsync.when(
                data: (state) {
                  final registros = state.registros;
                  final hasMessage = state.statusMessage.isNotEmpty;
                  final hasError = state.hasError;
                  final isDarkMode =
                      Theme.of(context).brightness == Brightness.dark;
                  final fechaCierreColorText = isDarkMode
                      ? const Color.fromARGB(255, 95, 199, 25)
                      : const Color.fromARGB(255, 18, 166, 16);
                  final fechaIngresoDatosColorText = isDarkMode
                      ? const Color.fromARGB(255, 180, 176, 176)
                      : const Color.fromARGB(255, 125, 125, 125);
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: alto,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          RefreshIndicator(
                            onRefresh: onRefresh,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(),
                              itemCount: registros.length,
                              itemBuilder: (context, index) {
                                final registro = registros[index];
                                return ListTile(
                                  leading: CircleWidget(
                                    title: registro.nombreCompletoCliente,
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          registro.nombreCompletoCliente,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // if (registro.isClosed)
                                      // Text(
                                      //   '05-06-2025',
                                      //   style: textTheme.bodySmall?.apply(
                                      //     color: fechaCierreColorText,
                                      //   ),
                                      // ) else
                                      Text(
                                        registro.fechaIngresoDatos
                                            .getFormat01(),
                                        style: textTheme.bodySmall?.apply(
                                          color: fechaIngresoDatosColorText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.whatsapp,
                                              color: Colors.green[400],
                                            ),
                                            const SizedBox(width: 8),
                                            Text(registro.fonoContactoCliente),
                                          ],
                                        ),
                                      ),
                                      if (registro.isClosed)
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.handshake,
                                              color: isDarkMode
                                                  ? const Color.fromARGB(
                                                      255,
                                                      60,
                                                      254,
                                                      1,
                                                    )
                                                  : const Color.fromARGB(
                                                      255,
                                                      39,
                                                      7,
                                                      135,
                                                    ),
                                            ),
                                            if (registro.fechaDeCierre !=
                                                null) ...[
                                              const SizedBox(width: 8),
                                              Text(
                                                registro.fechaDeCierre!
                                                    .getFormat01(),
                                                style: textTheme.bodySmall
                                                    ?.apply(
                                                      color:
                                                          fechaCierreColorText,
                                                    ),
                                              ),
                                            ],
                                          ],
                                        ),
                                    ],
                                  ),
                                  onTap: () => context.push(
                                    Rutas.recordDetails,
                                    extra: registro.idRegistro,
                                  ),
                                );
                              },
                            ),
                          ),
                          if (hasMessage)
                            StatusMessageWidget(
                              message: state.statusMessage,
                              hasError: hasError,
                            ),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: $error, $stackTrace')),
                  );
                },
                // loading: () => const ProductShimmerList(),
                loading: () => const SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        CircularProgressIndicator(strokeWidth: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: registrosStateAsync.hasValue
          ? BotonAnimado(
              title: 'Nuevo Registro',
              scrollController: getScrollController(),
              onPressed: () => onPressedAgregarRegistro(context),
            )
          : null,
    );
  }
}

const colores = [
  Color.fromARGB(255, 139, 0, 0), // Rojo oscuro
  Color.fromARGB(255, 255, 69, 0), // Rojo naranja
  Color.fromARGB(255, 184, 134, 11), // Amarillo oscuro
  Color.fromARGB(255, 34, 139, 34), // Verde bosque
  Color.fromARGB(255, 25, 25, 112), // Azul medianoche
  Color.fromARGB(255, 75, 0, 130), // Índigo
  Color.fromARGB(255, 139, 0, 139), // Magenta oscuro
  Color.fromARGB(255, 165, 42, 42), // Marrón
  Color.fromARGB(255, 255, 140, 0), // Naranja oscuro
  Color.fromARGB(255, 218, 165, 32), // Dorado oscuro
  Color.fromARGB(255, 85, 107, 47), // Verde oliva oscuro
  Color.fromARGB(255, 46, 125, 50), // Verde oscuro
  Color.fromARGB(255, 0, 100, 100), // Teal oscuro
  Color.fromARGB(255, 30, 144, 255), // Azul Dodger
  Color.fromARGB(255, 65, 105, 225), // Azul real
  Color.fromARGB(255, 72, 61, 139), // Azul pizarra oscuro
  Color.fromARGB(255, 123, 20, 115), // Púrpura oscuro
  Color.fromARGB(255, 199, 21, 133), // Violeta rojo medio
  Color.fromARGB(255, 160, 82, 45), // Marrón silla
  Color.fromARGB(255, 128, 0, 0), // Granate
  Color.fromARGB(255, 0, 128, 0), // Verde
  Color.fromARGB(255, 0, 0, 128), // Azul marino
  Color.fromARGB(255, 128, 0, 128), // Púrpura
  Color.fromARGB(255, 105, 105, 105), // Gris dim
  Color.fromARGB(255, 47, 79, 79), // Gris pizarra oscuro
  Color.fromARGB(255, 72, 61, 139), // Azul pizarra oscuro
];

class CircleWidget extends StatelessWidget {
  const CircleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final indexColor = (title.codeUnitAt(0) - 65).clamp(0, 25);

    final backgroundColor = colores[indexColor];

    return CircleAvatar(
      backgroundColor: backgroundColor,

      child: Text(
        title.getInitials(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
