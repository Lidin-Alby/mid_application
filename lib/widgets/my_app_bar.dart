import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  const MyAppBar({super.key, required this.onChanged});

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: const Color.fromARGB(255, 255, 252, 242),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: SizedBox(
          height: 34,
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/logoImg.jpg'),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: 15),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
