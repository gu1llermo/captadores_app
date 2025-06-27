import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';


import 'internet_connection_service.dart';
import 'internet_connection_status.dart';


class InternetConnectionServiceImpl extends InternetConnectionService {

  // Instancia de Connectivity
  final Connectivity _connectivity = Connectivity();

  // Instancia estática privada
  static InternetConnectionServiceImpl? _instance;

  late final StreamSubscription<List<ConnectivityResult>> _internetSubscription;
  final StreamController<InternetConnectionStatus> _statusController;
  // bool _isConnected = true;

  // Estado actual de la conexión
  InternetConnectionStatus _lastStatus = InternetConnectionStatus.connected;
  InternetConnectionStatus get status => _lastStatus;

  
  InternetConnectionServiceImpl._() :
  _statusController = StreamController<InternetConnectionStatus>.broadcast() {
    // Iniciar escuchando el estado de la conexión
    _initConnectivity();
    _internetSubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Método de fábrica para acceder a la instancia única
  factory InternetConnectionServiceImpl() {
    // Si la instancia no existe, la creamos
    _instance ??= InternetConnectionServiceImpl._();
    return _instance!;
  }
  
  // Método estático para obtener la instancia (alternativa)
  static InternetConnectionServiceImpl get instance {
    _instance ??= InternetConnectionServiceImpl._();
    return _instance!;
  }

    // Inicializar el estado de conectividad
  Future<void> _initConnectivity() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      _updateConnectionStatus(connectivityResult);
    } catch (e) {
      if (kDebugMode) {
        print('Error al inicializar la conectividad: $e');
      }
      _updateConnectionStatus([ConnectivityResult.none]);
    }
  }

  // Actualizar el estado de la conexión basado en los resultados de connectivity_plus
  void _updateConnectionStatus(List<ConnectivityResult> listConnectivityResult) {
    InternetConnectionStatus newStatus;
    
    if (listConnectivityResult.contains(ConnectivityResult.none)) {
      newStatus = InternetConnectionStatus.disconnected;
    } else {
      newStatus = InternetConnectionStatus.connected;
    }
    
    // switch (listConnectivityResult) {
    //   case ConnectivityResult.wifi:
    //   case ConnectivityResult.mobile:
    //   case ConnectivityResult.ethernet:
    //   case ConnectivityResult.vpn:
    //     newStatus = InternetConnectionStatus.connected;
    //     break;
    //   default:
    //     newStatus = InternetConnectionStatus.disconnected;
    // }
    
    // Solo notificar si hay un cambio en el estado
    if (_lastStatus != newStatus) {
      _lastStatus = newStatus;
      _statusController.add(newStatus);
    }
  }
  
  // Verificar el estado actual de la conexión
  Future<InternetConnectionStatus> checkConnection() async {
    final result = await _connectivity.checkConnectivity();

    InternetConnectionStatus newStatus;
    
    if (result.contains(ConnectivityResult.none)) {
      newStatus = InternetConnectionStatus.disconnected;
    } else {
      newStatus = InternetConnectionStatus.connected;
    }
    
    _lastStatus = newStatus;
    return newStatus;
  }

  // void _handleStatus(InternetStatus status) {
  //   switch (status) {
  //     case InternetStatus.connected:
  //       _statusController.add(InternetConnectionStatus.connected);
  //       _isConnected = true;
  //       break;
  //     case InternetStatus.disconnected:
  //       _statusController.add(InternetConnectionStatus.disconnected);
  //       _isConnected = false;
  //       break;
  //   }
  // }


  // @override
  // void pauseSubscription() {
  //   _internetSubscription.pause();
  // }

  // @override
  // void resumeSubscription() {
  //   _internetSubscription.resume();
  // }

  @override
  Stream<InternetConnectionStatus> get internetConnectionStatusStream => _statusController.stream;

  @override
  void dispose() {
    _internetSubscription.cancel();
    _statusController.close();
  }
  
  @override
  bool get isConnected => _lastStatus.isConnected;
  // @override
  // Future<bool> get isConnected async {
  //   final status = await checkConnection();
  //   return status.isConnected;
  // }
}
  