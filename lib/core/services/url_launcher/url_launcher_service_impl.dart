
import 'package:url_launcher/url_launcher.dart';

import 'url_launcher_service.dart';

class UrlLauncherServiceImpl extends UrlLauncherService {
  @override
  Future<void> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> abrirWhatsApp({
    required String telefono,
    required String mensaje,
  }) async {
    // Eliminar cualquier formato del número de teléfono (espacios, guiones, etc.)
    String numeroLimpio = telefono.replaceAll(RegExp(r'[^0-9]'), '');

    // El número debe incluir el código de país sin el signo +
    // Por ejemplo, para España sería: 34XXXXXXXXX

    // Codificar el mensaje para la URL
    String mensajeCodificado = Uri.encodeComponent(mensaje);

    final url = 'https://wa.me/$numeroLimpio?text=$mensajeCodificado';

    await openUrl(url);
  }

  @override
  Future<void> sendEmail({required String email}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      // query: encodeQueryParameters(<String, String>{
      //   'subject': 'Example Subject & Symbols are allowed!',
      // }),
    );
    await launchUrl(emailLaunchUri);
  }
}
