import 'package:deskcopilot/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

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
                context.read<Provide>().connect(
                    _addressController.text, int.parse(_portController.text));
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
