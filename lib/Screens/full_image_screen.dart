import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mid_application/ip_address.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen(
      {super.key, required this.imageUrl, required this.schoolCode});
  final String? imageUrl;
  final String schoolCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Image',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shape: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: '$ipv4/getPic/$schoolCode/$imageUrl',
          errorWidget: (context, url, error) => Text(
            'No Picture Uploaded',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
