import 'package:flutter/cupertino.dart';

import '../widgets/textFields.dart';

class TabsMainContainer extends StatelessWidget {
  final List<Widget> children;
  TabsMainContainer({this.children = const []});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
          ),
        ));
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final String label;
  final Widget widget;
  final dynamic onChanged;
  final dynamic initialValue;
  RowItem(
      {this.text = '',
        this.label = 'Default',
        this.onChanged,
        this.widget = const Text(''),
        this.initialValue
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                width: 300,
                child: Text(
                  text,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                width: 300,
                child: OwnTextField(
                  onChanged: onChanged,
                  labelText: label,
                  initialValue: initialValue,
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(5),
              width: widget == const Text('') ? 0 : 175,
              child: Container(
                child: widget,
              ))
        ],
      ),
    );
  }
}
