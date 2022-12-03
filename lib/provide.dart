import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Provide extends ChangeNotifier {
  WebSocketChannel? _server;
  dynamic _dict;

  get dict => _dict;

  void initialize(String address, int port) {
    _server = WebSocketChannel.connect(Uri.parse('ws://$address:$port'));
    _server?.stream.listen((event) => receiveMessage(event));
    sendMessage('layouts');
  }

  void receiveMessage(String message) {
    _dict = json.decode(message);
    notifyListeners();
  }

  void sendMessage(String message) => _server?.sink.add(message);

  void refresh() {
    sendMessage('layouts');
  }
}
