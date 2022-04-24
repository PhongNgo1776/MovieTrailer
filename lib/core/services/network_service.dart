import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movie_trailer/main.dart';

class NetworkService {
  late bool _isConnected;
  bool get isConnected => _isConnected;

  StreamController connectController = new StreamController<bool>.broadcast();
  Stream get counterStream => connectController.stream;
  late Connectivity _connectivity;

  void checkConnection() async {
    _connectivity = getIt<Connectivity>();
    var result = await _connectivity.checkConnectivity();
    _isConnected = _checkConnected(result);
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      var connected = _checkConnected(result);
      connectController.add(connected);
    });
  }

  bool _checkConnected(ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.wifi;
  }
}
