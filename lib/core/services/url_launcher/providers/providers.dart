

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../url_launcher_service.dart';
import '../url_launcher_service_impl.dart';

part 'providers.g.dart';

@Riverpod()
UrlLauncherService urlLauncherService(Ref ref) => UrlLauncherServiceImpl();