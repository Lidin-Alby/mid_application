import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectWidget extends StatelessWidget {
  const DateSelectWidget({
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
          height: 43,
          width: 250,
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
