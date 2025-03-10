import 'package:flutter/material.dart';

class SchoolDashboard extends StatelessWidget {
  const SchoolDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color.fromARGB(255, 255, 252, 242),
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
                Text('Details', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  elevation: 10,
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
                                fontWeight: FontWeight.w400,
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
                        // padding: EdgeInsets.symmetric(vertical: ),
                        height: 150,
                        color: const Color.fromARGB(255, 245, 243, 244),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '728',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 255, 252, 242),
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    size: 24,
                                  ),
                                ),
                                Text('Students'),
                              ],
                            ),
                            Column(
                              children: [
                                Text('728'),
                                Icon(Icons.person_outline_rounded),
                                Text('Students'),
                              ],
                            ),
                            Column(
                              children: [
                                Text('728'),
                                Icon(Icons.person_outline_rounded),
                                Text('Students'),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 130,
                            width: 130,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.black,
                          child: Container(
                            height: 130,
                            width: 130,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
