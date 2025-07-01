import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:captadores_app/core/extensions/datetime_utils_extension.dart';
import 'package:captadores_app/core/extensions/strings_utils_extension.dart';
import 'package:captadores_app/features/registros/presentation/providers/registros_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/presentation/widgets/widgets.dart';

class RegistrosScreen extends ConsumerWidget {
  const RegistrosScreen({super.key});

  Future<void> onRefresh() async {}

  Future<void> onPressedCerrarSesion(BuildContext context, WidgetRef ref) async {
   

    if (!context.mounted) return;

    // Mostrar diálogo de confirmación
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosStateAsync = ref.watch(registrosNotifierProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: CustomDrawer(
        onPressedCerrarSesion: () => onPressedCerrarSesion(context, ref),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh, // _handleRefresh(context, ref, documentsState);

        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: const Text('Captadores DLC'),
              floating: true,
              snap: true,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
              
            ),
            registrosStateAsync.when(
              data: (data) {
                final registros = data.registros;
                return SliverList.builder(
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
                          // Text(registro.fechaIngresoDatos.getFormat01(), style: TextStyle( color: Colors.grey.shade600),),
                          Text(
                            registro.fechaIngresoDatos.getFormat01(),
                            style: textTheme.bodySmall?.apply(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green[400],
                          ),
                          const SizedBox(width: 8),
                          Text(registro.fonoContactoCliente),
                        ],
                      ),
                      onTap: () {
                        
                      },
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: $error, $stackTrace')),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            ),
          ],
        ),
      ),
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
