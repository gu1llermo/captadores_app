abstract class UrlLauncherService {
  Future<void> openUrl(String url);
  Future<void> abrirWhatsApp({required String telefono, required String mensaje});
  Future<void> sendEmail({required String email});
}
