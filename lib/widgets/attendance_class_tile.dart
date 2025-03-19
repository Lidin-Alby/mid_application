import 'package:flutter/material.dart';
import 'package:mid_application/widgets/my_popup_menu_button.dart';

class AttendanceClassTile extends StatelessWidget {
  const AttendanceClassTile({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 243, 244),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // height: 100,
                // padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                width: 95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(6)),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Text(
                  '12th - A',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/logoImg.jpg'),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abinanad Shukala',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Class Teacher',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w300),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Students :',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '54',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: MyPopupMenuButton(
                              label: 'Mark Attendance',
                              icon: Icons.check,
                            ),
                          ),
                          PopupMenuItem(
                            child: MyPopupMenuButton(
                              label: 'Manual Attendance',
                              icon: Icons.book_outlined,
                            ),
                          ),
                          PopupMenuItem(
                            child: MyPopupMenuButton(
                              label: 'View Attendance',
                              icon: Icons.view_column,
                            ),
                          ),
                          PopupMenuItem(
                            child: MyPopupMenuButton(
                              label: 'Download Report',
                              icon: Icons.download_outlined,
                            ),
                          ),
                        ],
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
