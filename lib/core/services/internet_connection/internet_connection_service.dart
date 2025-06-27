import 'internet_connection_status.dart';

abstract class InternetConnectionService {
  void dispose();
  Stream<InternetConnectionStatus> get internetConnectionStatusStream;
  bool get isConnected;
  // Future<bool> get isConnected;
}
