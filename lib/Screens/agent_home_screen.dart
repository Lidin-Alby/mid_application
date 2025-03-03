import 'package:flutter/material.dart';

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
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {},
                style: IconButton.styleFrom(backgroundColor: Colors.red),
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Card.outlined(
            child: Text('data'),
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}
