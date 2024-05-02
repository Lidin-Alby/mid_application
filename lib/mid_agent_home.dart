import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:mid_application/each_school.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'all_list.dart';
import 'drawer.dart';
import 'search_page.dart';
import 'ip_address.dart';
import 'add_menu.dart';
import 'attendance_mid.dart';
import 'mid_tile_widget.dart';
import 'ready_print.dart';
import 'unchecked_data_page.dart';
import 'without_photos.dart';

class MidAgentHome extends StatefulWidget {
  const MidAgentHome({super.key});

  @override
  State<MidAgentHome> createState() => _MidAgentHomeState();
}

class _MidAgentHomeState extends State<MidAgentHome> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController schoolCode = TextEditingController();
  TextEditingController schoolName = TextEditingController();
  TextEditingController schoolPassword = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController email = TextEditingController();
  late Future _myMidSchools;
  late String agentMob;
  int? _selectedIndex;
  late String? user;
  List schools = [];

  getMyMidSchools() async {
    // var client = BrowserClient()..withCredentials = true;

    var url = Uri.parse('$ipv4/getMyMidSchools');
    final String token = await getAuthToken();
    var res = await http.get(url, headers: {'authorization': token});
    print(res.body);
    var data = jsonDecode(res.body);
    agentMob = data['mob'];

    return data['schools'];
  }

  getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    user = prefs.getString('user');
    return token ?? '';
  }

  addMidSchool() async {
    if (_formKey.currentState!.validate()) {
      // var client = BrowserClient()..withCredentials = true;
      var url = Uri.parse('$ipv4/addNewSchoolMid');
      var res = await http.post(url, body: {
        'schoolCode': schoolCode.text.trim(),
        'principalPhone': mob.text.trim(),
        'schoolName': schoolName.text.trim(),
        'schoolPassword': schoolPassword.text.trim(),
        'agentMob': agentMob,
        'email': email.text.trim()
      });

      if (res.body == 'true') {
        if (mounted) {
          Navigator.of(context).pop();
        }
        setState(() {
          schoolCode.clear();
          schoolName.clear();
          schoolPassword.clear();
          mob.clear();
          email.clear();
          _myMidSchools = getMyMidSchools();
        });
      } else {
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[600],
              behavior: SnackBarBehavior.floating,
              content: Row(
                children: [
                  Text(
                    res.body,
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    _myMidSchools = getMyMidSchools();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 645) {
      _selectedIndex = null;
    }
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu_rounded),
        //   onPressed: () {},
        // ),
        title: Text('Dashboard'),
      ),
      drawer: MidDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: OutlinedButton(
                  //       onPressed: () => showDialog(
                  //             context: context,
                  //             builder: (context) => Dialog(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(20),
                  //                 child:

                  //               ),
                  //             ),
                  //           ),
                  //       child: Text('Add School')),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Expanded(
                      child: FutureBuilder(
                    future: _myMidSchools,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        schools = snapshot.data;

                        return schools.isEmpty
                            ? Center(child: Text('No schools Added'))
                            : ListView.separated(
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: schools.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: index == schools.length - 1
                                      ? EdgeInsets.only(bottom: 70)
                                      : EdgeInsets.zero,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      onForegroundImageError:
                                          (exception, stackTrace) =>
                                              CircleAvatar(
                                        foregroundImage: AssetImage(
                                            'assets/images/logoImg.jpg'),
                                      ),
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 50,
                                      ),
                                      key: UniqueKey(),
                                      foregroundImage: schools[index]
                                                      ['schoolLogo'] ==
                                                  '' ||
                                              !schools[index]
                                                  .containsKey('schoolLogo')
                                          ? AssetImage(
                                              'assets/images/logoImg.jpg')
                                          : NetworkImage(
                                                  "${Uri.parse('$ipv4/getSchoolLogoMid/${schools[index]['schoolCode']}')}")
                                              as ImageProvider,
                                    ),
                                    selected: index == _selectedIndex,
                                    selectedColor: Colors.white,
                                    selectedTileColor: Colors.indigo,
                                    onTap: width > 645
                                        ? () {
                                            setState(() {
                                              _selectedIndex = index;
                                            });
                                          }
                                        : () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => RightMenu(
                                                schoolCode: schools[index]
                                                    ['schoolCode'],
                                                user: user!,
                                                // schoolName: schools[index]
                                                //     ['schoolName'],
                                              ),
                                            )),
                                    title: Text(
                                      schools[index]['schoolName'],
                                    ),
                                    visualDensity: VisualDensity(vertical: -1),
                                    subtitle:
                                        Text(schools[index]['schoolCode']),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EachSchool(
                                              schoolCode: schools[index]
                                                  ['schoolCode'],
                                              listRefresh: () {
                                                setState(() {
                                                  _myMidSchools =
                                                      getMyMidSchools();
                                                });
                                              },
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
                ],
              ),
            ),
            if (width > 645) VerticalDivider(),
            if (width > 645)
              Expanded(
                flex: 3,
                child: _selectedIndex != null
                    ? RightMenu(
                        schoolCode: schools[_selectedIndex!]['schoolCode'],
                        user: user!,
                        // schoolName: schools[_selectedIndex!]['schoolName'],
                      )
                    : schools.isNotEmpty
                        ? SizedBox()
                        : Center(child: Text('Select School to show menu')),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          showDragHandle: true,
          // isScrollControlled: false,
          isScrollControlled: true,
          context: context,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  20, 20, 20, MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: schoolCode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'School Code',
                          // isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: mob,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Mobile No.',
                          // isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: schoolPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            child: FilledButton.tonal(
                                // style: TextButton.styleFrom(
                                //     foregroundColor: Colors.white,
                                //     backgroundColor: Colors.indigo),
                                //   splashRadius: 25,
                                child: Icon(Icons.refresh_rounded),
                                onPressed: () {
                                  const chars =
                                      'abcdefghijklmnopqrstuvwxyz1234567890@#%!*';

                                  setState(() {
                                    schoolPassword.text = String.fromCharCodes(
                                      Iterable.generate(
                                        6,
                                        (_) => chars.codeUnitAt(
                                          Random().nextInt(chars.length),
                                        ),
                                      ),
                                    );
                                  });
                                }),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'School Password',
                          // isDense: true,
                          helperStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: schoolName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'School Name',
                          // isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Email',
                          // isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FilledButton(onPressed: addMidSchool, child: Text('Add')),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        label: Text('Add School'),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }
}

class RightMenu extends StatefulWidget {
  const RightMenu({super.key, required this.schoolCode, required this.user});

  final String schoolCode;
  final String user;

  @override
  State<RightMenu> createState() => _RightMenuState();
}

class _RightMenuState extends State<RightMenu> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int _currentPageIndex = 0;
  late Future _getSchoolDetails;
  String? schoolName;
  late String? schoolCode;
  late bool lastPage;

  getSchoolDetails() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getmidSchoolDetails/$schoolCode');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);

    print(data);
    return data;
  }

  // getschoolCode() async {
  //   final SharedPreferences prefs = await _prefs;
  //   schoolCode = prefs.getString('schoolCode');
  // }

  @override
  void initState() {
    lastPage = !Navigator.of(context).canPop();
    schoolCode = widget.schoolCode;
    _getSchoolDetails = getSchoolDetails();
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant RightMenu oldWidget) {
  //   if (widget.schoolCode != oldWidget.schoolCode) {
  //     setState(() {
  //       _getSchoolDetails=getSchoolDetails();
  //     });
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.grey[50]),
      child: SafeArea(
        child: Scaffold(
          body: _currentPageIndex == 0
              ? Scaffold(
                  appBar: AppBar(
                    title: Text('Dashboard'),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchPage(
                            schoolCode: widget.schoolCode,
                          ),
                        )),
                        icon: Icon(Icons.search),
                      )
                    ],
                  ),
                  drawer: lastPage ? MidDrawer() : null,
                  body: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: _getSchoolDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map school = snapshot.data;
                          schoolName = school['schoolName'];
                          return Column(
                            children: [
                              Card.outlined(
                                child: ListTile(
                                  leading: CircleAvatar(
                                      child: Icon(Icons.business_rounded)),
                                  title: Text(
                                    schoolName.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(schoolCode.toString()),
                                ),
                              ),
                              Row(
                                children: [
                                  MidTile(
                                    icon: Icons.list_alt_rounded,
                                    title: 'List',
                                    color: Colors.orange.shade200,
                                    callback: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => ListAll(
                                                schoolCode: widget.schoolCode,
                                                user: widget.user,
                                              )),
                                    ),
                                  ),
                                  MidTile(
                                    icon: Icons.school_rounded,
                                    title: 'Unchecked Data',
                                    color: Colors.indigo,
                                    // count: (counts['staffNotReady'] +
                                    //     counts['studentNotReady']),
                                    callback: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UncheckedDataPage(
                                          schoolCode: widget.schoolCode,
                                          user: widget.user,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MidTile(
                                      icon: Icons.no_photography_rounded,
                                      title: 'Without Photos',
                                      color: Colors.pink,
                                      callback: () =>
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WithoutPhotosPage(
                                                schoolCode: widget.schoolCode,
                                                user: widget.user,
                                              ),
                                            ),
                                          )),
                                  MidTile(
                                    icon: Icons.print_rounded,
                                    title: 'Ready to Print',
                                    color: Colors.green,
                                    // count: (counts['staffReady'] +
                                    //     counts['studentReady']),
                                    callback: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ReadyPrintPage(
                                          schoolCode: widget.schoolCode,
                                          user: widget.user,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MidTile(
                                    icon: Icons.login_rounded,
                                    title: 'Login Pending',
                                    color: Colors.teal,
                                    callback: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            title: Text('Login Pending'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  MidTile(
                                    icon: Icons.badge_rounded,
                                    title: 'Card Designs',
                                    color: Colors.cyan,
                                    callback: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            title: Text('Card Designs'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // ElevatedButton(
                              //     onPressed: () => Navigator.of(context)
                              //             .push(MaterialPageRoute(
                              //           builder: (context) => CameraModule(),
                              //         )),
                              //     child: Text('Camers'))
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  )),
                )
              : AttendanceMid(schoolCode: widget.schoolCode),
          floatingActionButton: _currentPageIndex == 0
              ? FloatingActionButton(
                  child: Icon(Icons.add_rounded),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (context) => AddPage(
                      schoolCode: widget.schoolCode, user: widget.user,
                      // schoolName: schoolName!.toString(),
                    ),
                  ),
                )
              : null,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentPageIndex,
            onDestinationSelected: (value) {
              setState(() {
                _currentPageIndex = value;
              });
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
              NavigationDestination(
                  icon: Icon(Icons.assignment_turned_in_rounded),
                  label: 'Attendance')
            ],
            // items: [
            //   BottomNavigationBarItem(
            //       icon: , label: 'Dashboard'),
            //   BottomNavigationBarItem(
            //       icon:
            //       label: 'Attendance')
            // ],
          ),
        ),
      ),
    );
  }
}

class Newpage extends StatelessWidget {
  const Newpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
