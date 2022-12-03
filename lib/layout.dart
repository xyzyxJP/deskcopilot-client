import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Layout extends StatefulWidget {
  final dynamic dict;

  const Layout({super.key, this.dict});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.dict['Width'] * widget.dict['Height'],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.dict['Width'],
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: ((context, index) => _buildButton(context, index))),
    );
  }

  Widget _buildButton(BuildContext context, int index) {
    num x = index % widget.dict['Width'];
    num y = index == 0 ? 0 : (index / widget.dict['Width']).floor();
    dynamic button = widget.dict['Buttons'][y][x];

    return OutlinedButton(
      onPressed: () {
        if (button['Type'] != 1) return;
        if (kDebugMode) {
          print('Button pressed: ${button['Name']}');
        }
      },
      onLongPress: () {
        if (button['Type'] != 2) return;
        if (kDebugMode) {
          print('Button long pressed: ${button['Name']}');
        }
      },
      child: Column(
        children: [
          Text(button['Name']),
          Visibility(
            visible: button['Type'] == 3,
            child: Text(button['Value']),
          )
        ],
      ),
    );
  }
}
