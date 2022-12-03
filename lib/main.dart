import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeskCopilot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  var _channel;
  var _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeskCopilot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                ],
                controller: _addressController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Server Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _portController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Server Port',
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                _channel = WebSocketChannel.connect(
                  Uri.parse(
                      'ws://${_addressController.text}:${_portController.text}'),
                );
                _channel.stream.listen((message) {
                  setState(() {
                    _message = message;
                  });
                });
                _channel.sink.add('layouts');
              },
              child: const Text('Connect'),
            ),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
