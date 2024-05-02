import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'textfield_widget.dart';

import 'ip_address.dart';

class MidHome extends StatefulWidget {
  const MidHome({super.key});

  @override
  State<MidHome> createState() => _MidHomeState();
}

class _MidHomeState extends State<MidHome> {
  TextEditingController agentName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mob = TextEditingController();
  late Future _getAgents;

  addAgent() async {
    var url = Uri.parse('$ipv4/addAgent');
    var res = await http.post(url, body: {
      'mob': mob.text.trim(),
      'password': password.text.trim(),
      'fullName': agentName.text.trim()
    });
    print(res.body);
    if (res.body == 'true') {
      setState(() {
        _getAgents = getAgents();
      });
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  getAgents() async {
    var url = Uri.parse('$ipv4/getAgents');
    var res = await http.get(url);
    print(res.body);
    var data = jsonDecode(res.body);
    return data;
  }

  @override
  void initState() {
    _getAgents = getAgents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) =>
                      Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Add New Agent',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                        label: 'Agent Name (Full Name)',
                        controller: agentName,
                        isEdit: true),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        label: 'Mobile Number', controller: mob, isEdit: true),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: password,
                        decoration: InputDecoration(
                          // suffixIconColor: Colors.red,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.indigo),
                                //   splashRadius: 25,
                                child: Icon(Icons.refresh_rounded),
                                onPressed: () {
                                  const chars =
                                      'abcdefghijklmnopqrstuvwxyz1234567890@#%!*';

                                  setState(() {
                                    password.text = String.fromCharCodes(
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
                          isDense: true,
                          label: Text('Password'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(onPressed: addAgent, child: Text('Add')),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Mid Agent'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: _getAgents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List agents = [];
                  agents = snapshot.data;
                  return agents.isEmpty
                      ? Text('No Agents added')
                      : Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Table(
                            border: TableBorder(
                              verticalInside: BorderSide(),
                            ),
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange.shade50),
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Mobile No.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Password',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                              for (Map agent in agents)
                                TableRow(children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(agent['fullName']),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(agent['mob']),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(agent['password']),
                                    ),
                                  )
                                ])
                            ],
                          ),
                        );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
