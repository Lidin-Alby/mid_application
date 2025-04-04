import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mid_application/ip_address.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget(
      {super.key,
      required this.profilePic,
      this.size = 45,
      required this.schoolCode});
  final String profilePic;
  final double size;
  final String schoolCode;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, imageUrl) => SizedBox(
        width: size,
        height: size,
      ),
      imageUrl: '$ipv4/getPic/$schoolCode/$profilePic',
      imageBuilder: (context, imageProvider) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('$ipv4/getPic/$schoolCode/$profilePic'),
          ),
        ),
      ),
      errorWidget: (context, imageUrl, error) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/logoImg.jpg'),
          ),
        ),
      ),
    );
  }
}
