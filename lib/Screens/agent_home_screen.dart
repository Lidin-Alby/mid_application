import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_application/Screens/edit_or_add_school.dart';
import 'package:mid_application/Screens/login_screen.dart';
import 'package:mid_application/models/school.dart';
import 'package:mid_application/providers/login_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AgentHomeScreen extends ConsumerWidget {
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DashBoard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Slidable(
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  icon: Icons.edit_outlined,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(6)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: (context) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditOrAddSchool(
                        school: School(
                          schoolCode: '108',
                          schoolName: 'SVP',
                          principalPhone: '9422',
                        ),
                      ),
                    ),
                  ),
                )
              ]),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                // margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/logoImg.jpg'),
                    ),
                    Column(
                      children: [
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditOrAddSchool(
              school: School(
                schoolCode: '108',
                schoolName: 'SVPS',
                principalPhone: 'Lidin Alby',
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                loginNotifier.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
