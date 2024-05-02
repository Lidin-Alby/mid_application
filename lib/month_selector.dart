import 'package:flutter/material.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector(
      {super.key, required this.selectedDate, required this.setYear});
  final DateTime selectedDate;
  final Function(DateTime) setYear;

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late int selectedYear;
  late int selectedMonth;
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  @override
  void initState() {
    selectedYear = widget.selectedDate.year;
    selectedMonth = widget.selectedDate.month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          selectedYear--;
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios_rounded)),
                  Text(selectedYear.toString()),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          selectedYear++;
                        });
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Wrap(
                      children: List.generate(
                        months.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedMonth = index + 1;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selectedMonth == (index + 1)
                                    ? Theme.of(context).primaryColor
                                    : null,
                                borderRadius: BorderRadius.circular(8)),
                            width: constraints.maxWidth / 5,
                            child: Text(
                              months[index],
                              style: selectedMonth == (index + 1)
                                  ? TextStyle(color: Colors.white)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel')),
                        SizedBox(
                          width: 10,
                        ),
                        FilledButton(
                            onPressed: () {
                              widget.setYear(
                                DateTime(selectedYear, selectedMonth),
                              );
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
