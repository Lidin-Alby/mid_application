import 'package:flutter/material.dart';

class StaffDetailsScreen extends StatefulWidget {
  const StaffDetailsScreen({super.key});

  @override
  State<StaffDetailsScreen> createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Staff'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
