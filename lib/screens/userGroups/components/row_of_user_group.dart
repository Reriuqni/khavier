import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';

class RowOfUserGroup extends StatefulWidget {
  final String nameOfGroup;
  final VoidCallback? press;

  const RowOfUserGroup({
    Key? key,
    required this.nameOfGroup,
    this.press,
  }) : super(key: key);

  @override
  _RowOfUserGroup createState() => _RowOfUserGroup();
}

class _RowOfUserGroup extends State<RowOfUserGroup> {
  @override
  void dispose() {
    super.dispose();
  }

  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onHover: (_) => setState(() => _color = _ ? secondaryColor : Colors.black),
        onTap: () => widget.press,
        child: Text(widget.nameOfGroup, style: TextStyle(color: _color, fontSize: 20)),
      ),
    ));
  }
}
