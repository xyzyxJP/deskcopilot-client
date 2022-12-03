import 'package:deskcopilot/layout.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeskCopilot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                      ],
                      controller: _addressController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Server Address',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _portController,
                      decoration: const InputDecoration(
                        labelText: 'Server Port',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.connected_tv),
                  onPressed: () {
                    context.read<Provide>().initialize(_addressController.text,
                        int.parse(_portController.text));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<Provide>().refresh();
                  },
                ),
              ],
            ),
            context.watch<Provide>().dict == null
                ? const Text('No Layouts')
                : Layout(dict: context.watch<Provide>().dict[0]),
          ],
        ),
      ),
    );
  }
}
