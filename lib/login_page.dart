import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/browser_client.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'ip_address.dart';
import 'mid_agent_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController schoolCode = TextEditingController();
  late String logSchoolCode;
  // int _selected = 0;

  List schoolCodesList = [];
  bool logged = false;

  goFun(Map state) async {
    // if (state == 'own') {
    //   // context.go('/myApp');
    // } else
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', state['token']);
    prefs.setString('user', state['user']);
    prefs.setString('schoolCode', state['schoolCode']);
    print(state['user']);
    print(state['schoolCode']);

    if (mounted) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        if (state.containsKey('user')) {
          if (state['user'] == 'agent') {
            return MidAgentHome();
          } else {
            return RightMenu(
              schoolCode: state['schoolCode'],
              user: state['user'],
            );
          }
        } else {
          return LoginPage();
        }
      }));
    } else {
      //context.go('/students');
      print(state);
      logSchoolCode = schoolCode.text.trim();
      // context.go('/$state');
    }
  }

  // getSchoolCodes() async {
  //   var url = Uri.parse('$ipv4/getSchoolCodes');
  //   print(url);
  //   var res = await http.get(url);
  //   if (res.body.isEmpty) {
  //     return;
  //   } else {
  //     List data = jsonDecode(res.body);
  //     print(data);
  //     schoolCodesList = data.map((e) => e['schoolCode']).toList();
  //     return data;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              // elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              //  color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.cyan[900],
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: userId,
                        decoration: InputDecoration(
                            labelText: 'UserID / Admission No.',
                            // filled: true,
                            // fillColor: Colors.indigo[50],
                            border: OutlineInputBorder(),
                            isDense: true),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: schoolCode,
                        decoration: InputDecoration(
                            labelText: 'School Code',
                            // filled: true,
                            // fillColor: Colors.indigo[50],
                            border: OutlineInputBorder(),
                            isDense: true),
                      ),
                    ),
                    // Container(
                    //   alignment: AlignmentDirectional.center,
                    //   width: 300,
                    //   height: 43,
                    //   // margin: EdgeInsets.only(top: 10),
                    //   decoration: BoxDecoration(
                    //       color: Colors.indigo[50],
                    //       border: Border.all(
                    //         color: Colors.grey.shade600,
                    //       ),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   child: DropdownButton(
                    //     isExpanded: true,
                    //     borderRadius: BorderRadius.circular(10),
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 12, vertical: 4),
                    //     value: selectedCode,
                    //     isDense: true,
                    //     underline: Text(''),
                    //     hint: Text('School Code'),
                    //     items: schoolCodesList
                    //         .map((e) => DropdownMenuItem(
                    //             value: e.toString(),
                    //             child: Text(e.toString())))
                    //         .toList(),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedCode = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: password,
                        decoration: InputDecoration(
                            // filled: true,
                            // fillColor: Colors.indigo[50],
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            isDense: true),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                      onPressed: () async {
                        // var client = BrowserClient()..withCredentials = true;

                        http.Response response;
                        var url = Uri.parse('$ipv4/loginMid');
                        print(url);
                        response = await http.post(
                          url,
                          body: {
                            'userName': userId.text.trim(),
                            'password': password.text.trim(),
                            'schoolCode': schoolCode.text.trim(),
                            'ver': kIsWeb.toString()
                          },
                        );
                        Map data = jsonDecode(response.body);
                        print(data);

                        goFun(data);
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
