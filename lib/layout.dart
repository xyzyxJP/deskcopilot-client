import 'package:flutter/cupertino.dart';
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
    return OutlinedButton(
      onPressed: () {},
      child: Text(widget.dict['Buttons']
              [index == 0 ? 0 : (index / widget.dict['Width']).floor()]
          [index % widget.dict['Width']]['Name']),
    );
  }
}
