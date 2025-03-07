import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mid_application/Blocs/login_bloc.dart';
import 'package:mid_application/Blocs/login_event.dart';

import 'package:mid_application/Blocs/school_bloc.dart';
import 'package:mid_application/Blocs/school_event.dart';
import 'package:mid_application/Blocs/school_state.dart';
import 'package:mid_application/Screens/add_school_model.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

// class AgentHomeScreen extends ConsumerWidget {
//   const AgentHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final loginNotifier = ref.read(loginProvider.notifier);
//     final schoolListAsyncValue = ref.read(schoolListProvider);

//     return

//   }
// }

// import 'package:flutter/material.dart';

class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider(
        create: (context) => SchoolBloc()..add(Loadschools()),
        child: BlocBuilder<SchoolBloc, SchoolState>(builder: (context, state) {
          if (state is SchoolError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is SchoolLoaded) {
            return state.schools.isEmpty
                ? Center(
                    child: Text('No schools added'),
                  )
                : ListView.builder(
                    itemCount: state.schools.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(12),
                      child: Slidable(
                        startActionPane:
                            ActionPane(motion: ScrollMotion(), children: [
                          SlidableAction(
                            icon: Icons.edit_outlined,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(6)),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (context) {},
                            // (context) => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => EditSchool(
                            //       school: School(
                            //         schoolCode: '108',
                            //         schoolName: 'SVP',
                            //         principalPhone: '9422',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          )
                        ]),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          // margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/logoImg.jpg'),
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.schools[index].schoolName.toString(),
                                  ),
                                  Text(
                                    state.schools[index].principalPhone
                                        .toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            isScrollControlled: true,
            showDragHandle: true,
            context: context,
            builder: (context) => AddSchoolModel()),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LogoutPressed());

                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LoginScreen(),
                //     ));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
