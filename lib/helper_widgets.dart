import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MidTextField extends StatelessWidget {
  const MidTextField(
      {Key? key,
      required this.label,
      required this.controller,
      this.isValidted = false,
      required this.isEdit})
      : super(key: key);
  final String label;
  final TextEditingController controller;

  final bool isValidted;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: isValidted
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
      readOnly: !isEdit,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        label: Text(label),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class MidDropDownWidget extends StatelessWidget {
  const MidDropDownWidget({
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
            height: 55,
            // margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButton(
              style: TextStyle(color: Colors.black),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              disabledHint: selected != null
                  ? Text(
                      selected.toString(),
                      style: TextStyle(color: Colors.black),
                    )
                  : Text(
                      title,
                      style: TextStyle(color: Colors.black),
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
          Positioned(
            top: -5,
            child: Container(
                margin: EdgeInsets.only(left: 8, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 3),
                color: Colors.grey[50],
                child: Text(
                  title,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                )),
          )
      ],
    );
  }
}

class MidDateSelectWidget extends StatelessWidget {
  const MidDateSelectWidget({
    Key? key,
    required this.title,
    required this.selectedDate,
    required this.isEdit,
    required this.callBack,
  }) : super(key: key);
  final String title;
  final String? selectedDate;
  final bool isEdit;
  final Function(dynamic) callBack;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          //  isAdd ? SystemMouseCursors.text :
          SystemMouseCursors.basic,
      child: InkWell(
        onTap: isEdit
            ? () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime.now());
                String selected = DateFormat('dd-MM-yyyy').format(date!);
                callBack(selected);
              }
            : null,
        child: SizedBox(
          height: 60,
          child: InputDecorator(
            decoration: InputDecoration(
                isDense: true,
                labelText: selectedDate == null ? null : title,
                border: OutlineInputBorder()),
            child: selectedDate == null
                ? Text(title,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600))
                : Text(
                    selectedDate!,
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }
}
