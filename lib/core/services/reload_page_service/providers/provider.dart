
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../reload_page_impl.dart';
import '../reload_page_service.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
ReloadPageService reloadPage(Ref ref) {
  return ReloadPageImpl();
}