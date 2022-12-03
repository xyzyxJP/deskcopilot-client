import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Socket {
  WebSocketChannel? _server;

  Socket(String address, int port) {
    _server = WebSocketChannel.connect(Uri.parse('ws://$address:$port'));
    _server?.stream.listen((event) => receiveMessage(event));
    sendMessage('layouts');
  }

  void receiveMessage(String message) {
    if (kDebugMode) {
      print(json.decode(message));
    }
  }

  void sendMessage(String message) => _server?.sink.add(message);
}
