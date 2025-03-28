import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key, required this.imageUrl, this.size = 45});
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, imageUrl) => SizedBox(
        width: size,
        height: size,
      ),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
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
