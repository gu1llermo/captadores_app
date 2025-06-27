

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../internet_connection_service.dart';
import '../internet_connection_service_impl.dart';
import '../internet_connection_status.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
InternetConnectionService internetConnectionService(Ref ref) {
  return InternetConnectionServiceImpl();
}

@Riverpod(keepAlive: true, dependencies: [internetConnectionService])
class InternetConnectionNotifier extends _$InternetConnectionNotifier {
  // late final StreamSubscription<InternetConnectionStatus> _internetSubscription;
  late final InternetConnectionService _internetConnectionService;
  @override
  InternetConnectionStatus build() {
    _internetConnectionService = ref.read(
      internetConnectionServiceProvider,
    );
    final internetConnectionStatusStream =
        _internetConnectionService.internetConnectionStatusStream;
    internetConnectionStatusStream.listen((status) {
      state = status;
    });
    // lo inicializo como si estuviese conectado, luego se acomoda
    return InternetConnectionStatus.connected;
  }

  

  // void pauseSubscription() {
  //   _internetSubscription.pause();
  //   _internetConnectionService.pauseSubscription();
  // }

  // void resumeSubscription() {
  //   _internetConnectionService.resumeSubscription();
  //   _internetSubscription.resume();
  // }

  

 
}
