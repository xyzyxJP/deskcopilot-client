import 'package:deskcopilot/socket.dart';
import 'package:flutter/foundation.dart';

class Provide extends ChangeNotifier {
  late Socket _socket;

  void connect(String address, int port) {
    _socket = Socket(address, port);
  }

  void refresh() {
    _socket.sendMessage('refresh');
    notifyListeners();
  }
}
