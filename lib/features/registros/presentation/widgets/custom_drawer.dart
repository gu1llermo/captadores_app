import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../authentication/presentation/providers/auth_provider.dart';


class CustomDrawer extends ConsumerWidget {
  final VoidCallback? onPressedCerrarSesion;


  const CustomDrawer({
    super.key,
    this.onPressedCerrarSesion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final authStateAsync = ref.watch(authNotifierProvider);
    // final user = authStateAsync.value?.user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Cabecera del Drawer con información del usuario
          UserAccountsDrawerHeader(
            accountName: Text(authStateAsync.value?.user?.nombreAsesor ?? ''),
            accountEmail: Text(authStateAsync.value?.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: colors.surface,
              child: Text(
                authStateAsync.value?.user?.initials ?? '',
                style: theme.textTheme.displaySmall,
                // style:  theme.textTheme.titleLarge!.copyWith(color: colors.onSurface) ,
              ),
            ),
            // otherAccountsPictures: [
            //   ClipRRect(
            //     borderRadius: BorderRadius.circular(20),
            //     child: Image.asset(
            //       'assets/images/mi_inventario_app_logo.webp',
            //       fit: BoxFit.cover,
            //       width: 20,
            //       height: 20,
            //     ),
            //   ),
            // ],
            decoration: BoxDecoration(color: colors.primary),
          ),

          // Elementos de menú
          ListTile(
            leading: const Icon(Icons.home),
            selected: true,
            title: const _TitleWidget('Inicio'),
            onTap: () {
              // Navegar a la página de inicio
              context.pop();
              // Aquí podrías navegar a la página home si no estás ya en ella
            },
          ),


          // ListTile(
          //   leading: const Icon(Icons.favorite),
          //   title: const Text('Favoritos'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const PlaceholderPage("Favoritos")),
          //     );
          //   },
          // ),

          // Divisor

          // Sección de configuración
          const Divider(),
          ListTile(
            leading: const Icon(FontAwesomeIcons.circleInfo),
            title: const _TitleWidget('Versión'),
            onTap: () async {
              final packageInfo = await PackageInfo.fromPlatform();
              final version = packageInfo.version;
              //final buildNumber = packageInfo.buildNumber;
              
              final versionInfo = 'Versión: $version';
              if (!context.mounted) return;
              await showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Versión de la App'),
                      content: Text(versionInfo),
                      actions: [
                        TextButton(
                          child: const Text('Cerrar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
              );
            },
          ),
          // Cerrar sesión
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const _TitleWidget('Cerrar Sesión'),
            onTap: onPressedCerrarSesion,
          ),
          // Contacto Desarrollador
          // ListTile(
          //   leading: const Icon(FontAwesomeIcons.whatsapp),
          //   title: const Text('Soporte'),
          //   onTap: onPressedSoporteButton,
          // ),
          // muestra la versión de la app usando el paquete package_info_plus
          
          // ListTile(
          //   leading: const Icon(FontAwesomeIcons.clipboard),
          //   title: const Text('Términos y Condiciones'),
          //   onTap: () {
          //     //context.pop(); // cerrar Drawer
          //     Clipboard.setData(const ClipboardData(text: 'Términos y Condiciones'));
          //   },
          // ),
        ],
      ),
    );
  }
}

// Página de ejemplo para mostrar al navegar
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Página de $title', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(title, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
