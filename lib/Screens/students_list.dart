import 'package:flutter/material.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 252, 242),
      appBar: AppBar(
        title: Text('Students'),
        centerTitle: true,
        actions: [Container()],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(6),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.5, color: Colors.black54)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/logoImg.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abinanad Shukala',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Admission No. - 1054',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
