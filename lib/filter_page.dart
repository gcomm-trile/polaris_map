import 'package:dino_map/constants.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final List<String> source;
  final Function(String selectedValue) savedData;
  FilterPage({Key key, this.source, this.savedData}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var _checkedValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.0,
        height: 300.00,
        child: Column(
          children: [
            // MyTextField(
            //   text: "",
            //   title: "Tìm sản phẩm",
            //   onChangedText: (textValue) {},
            // ),
            // _buildHeader,
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    shrinkWrap: true,
                    itemCount: widget.source.length,
                    itemBuilder: (context, index) {
                      return _buildRow(context, index, widget.source[index]);
                    })),
            RaisedButton(
              color: kPrimaryColor,
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  widget.savedData(_checkedValue);
                  Navigator.pop(context);
                });
              },
            )
          ],
        ));
  }

  Widget _buildRow(BuildContext context, int index, String value) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = value == _checkedValue;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isChecked) {
            // _checkedStock = new Stock();
          } else {
            _checkedValue = value;
          }
        });
      },
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: color,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
