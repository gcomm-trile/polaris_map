import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final Color color;
  final String title;
  final Function(bool checkedValue) onChangedCheck;
  MyCheckBox({Key key, this.color, this.title, this.onChangedCheck})
      : super(key: key);

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _check;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        children: [
          RaisedButton.icon(
            color: widget.color,
            textColor: Colors.white,
            icon: Icon(_check
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined),
            label: Container(
              width: 70,
              child: Text(
                widget.title,
                textAlign: TextAlign.start,
              ),
            ),
            onPressed: () {
              setState(() {
                _check = !_check;
                widget.onChangedCheck(_check);
              });
            },
          ),
        ],
      ),
    );
  }
}
