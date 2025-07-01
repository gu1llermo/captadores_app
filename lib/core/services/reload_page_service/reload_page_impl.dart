import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'reload_page_service.dart';

class ReloadPageImpl extends ReloadPageService{
  @override
  Future<void> reloadPage() async {
    if (kIsWeb) {
      final currentUrl = Uri.base;
      await launchUrl(currentUrl);
    }
    // en caso que es mobile no haca falta hacer reload
  }
}