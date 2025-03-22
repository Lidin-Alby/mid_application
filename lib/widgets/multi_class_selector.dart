import 'package:flutter/material.dart';
import 'package:mid_application/models/class_model.dart';

class MultiClassSelector extends StatelessWidget {
  const MultiClassSelector(
      {super.key,
      required this.classList,
      required this.onSelected,
      required this.selectedClasses,
      required this.onRemove});
  final List<ClassModel> classList;
  final Set selectedClasses;
  final Function(dynamic value) onSelected;
  final Function(dynamic value) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 96, 96, 96),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Stack(
          children: [
            InkWell(
              onTapDown: (details) {
                showMenu(
                  context: context,
                  constraints: BoxConstraints(minWidth: double.infinity),
                  position: RelativeRect.fromLTRB(
                    details.globalPosition.dx,
                    details.globalPosition.dy + 10,
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                  ),
                  items: classList
                      .map(
                        (e) => PopupMenuItem(
                          child: Text(e.classTitle),
                          value: e,
                          onTap: () => onSelected(e.classTitle),
                        ),
                      )
                      .toList(),
                );
              },
              child: Container(
                height: 34,
                width: double.infinity,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: .5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.arrow_drop_down),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 34,
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      ...selectedClasses.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          child: FilledButton(
                            onPressed: () => onRemove(e),
                            child: Row(
                              spacing: 3,
                              children: [
                                Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 16,
                                ),
                                Text(
                                  e,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                foregroundColor: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
