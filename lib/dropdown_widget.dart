import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.items,
    required this.title,
    required this.isEdit,
    required this.callBack,
    required this.selected,
  }) : super(key: key);
  final List items;
  final dynamic selected;
  final String title;
  final bool isEdit;
  final Function(dynamic) callBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: !isEdit,
          child: Container(
            margin: EdgeInsets.only(top: 3),
            alignment: AlignmentDirectional.center,
            width: 250,
            height: 45,
            // margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButton(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              disabledHint: selected != null
                  ? Text(
                      selected.toString(),
                      style: TextStyle(color: Colors.black),
                    )
                  : Text(
                      title,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
              value: selected,
              isExpanded: true,
              underline: Text(''),
              hint: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(title),
              ),
              items: items
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                callBack(value);
              },
            ),
          ),
        ),
        if (selected != null)
          Container(
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.symmetric(horizontal: 3),
              color: Colors.blue[50],
              child: Text(
                title,
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ))
      ],
    );
  }
}
