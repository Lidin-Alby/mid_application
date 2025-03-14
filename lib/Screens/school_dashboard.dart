import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mid_application/Screens/class_list.dart';
import 'package:mid_application/widgets/counts_column.dart';
import 'package:mid_application/widgets/menu_tile.dart';

class SchoolDashboard extends StatelessWidget {
  const SchoolDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.vertical(
                    //   top: Radius.circular(10),
                    // ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25,
                        spreadRadius: 2,
                        color: const Color.fromARGB(60, 0, 0, 0),
                      ),
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 252, 242),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 2,
                      color: const Color.fromARGB(60, 0, 0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/logoImg.jpg'),
                            ),
                            Spacer(),
                            Text(
                              'JKT Convent School',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '9422474584',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        // height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 245, 243, 244),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CountsColumn(
                              count: '728',
                              icon: Icons.person_outline_rounded,
                              label: 'Students',
                            ),
                            CountsColumn(
                                count: '16',
                                icon: Symbols.person_edit,
                                label: 'Class Teachers'),
                            CountsColumn(
                                count: '16',
                                icon: Icons.groups_outlined,
                                label: 'Total Staff')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  spacing: 20,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 25,
                                  spreadRadius: 2,
                                  color: const Color.fromARGB(60, 0, 0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Material(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClassList(),
                                    )),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 130,
                                  width: 130,
                                  // alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 8,
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        size: 28,
                                      ),
                                      Text(
                                        'List',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        MenuTile(
                          icon: Icons.cancel_outlined,
                          label: 'Unchecked',
                          cardColor: Colors.black87,
                          color: Colors.white,
                          count: '16',
                          onTap: () {},
                        )
                      ],
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        MenuTile(
                          icon: Icons.no_photography_outlined,
                          label: 'No Photos',
                          cardColor: Colors.black87,
                          color: Colors.white,
                          count: '10',
                          onTap: () {},
                        ),
                        MenuTile(
                          icon: Icons.print_outlined,
                          label: 'Ready to Print',
                          cardColor: Colors.white,
                          count: '10',
                          onTap: () {},
                        )
                      ],
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        MenuTile(
                          icon: Icons.restart_alt,
                          label: 'Printing',
                          cardColor: Colors.white,
                          count: '10',
                          onTap: () {},
                        ),
                        MenuTile(
                          icon: Icons.done_all_rounded,
                          label: 'Delivered',
                          cardColor: Colors.black87,
                          color: Colors.white,
                          count: '10',
                          onTap: () {},
                        )
                      ],
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        MenuTile(
                          icon: Icons.login_rounded,
                          label: 'Login Pending',
                          cardColor: Colors.black87,
                          color: Colors.white,
                          count: '10',
                          onTap: () {},
                        ),
                        MenuTile(
                          icon: Icons.badge_outlined,
                          label: 'Card Designs',
                          cardColor: Colors.white,
                          count: '10',
                          onTap: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ],
    );
  }
}
