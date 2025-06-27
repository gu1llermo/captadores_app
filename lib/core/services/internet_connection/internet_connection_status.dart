enum InternetConnectionStatus {
  connected,
  disconnected;
  bool get isConnected => this == InternetConnectionStatus.connected;
}