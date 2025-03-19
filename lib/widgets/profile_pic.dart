import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/logoImg.jpg'),
            ),
          ),
          Positioned(
            bottom: 3,
            right: -15,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
