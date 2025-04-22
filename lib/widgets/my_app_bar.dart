import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  const MyAppBar(
      {super.key,
      required this.onChanged,
      required this.onTap,
      this.readonly,
      this.autofocus,
      this.showSearch = true,
      required this.logo,
      required this.schoolCode});
  final bool? readonly;
  final bool? autofocus;
  final bool showSearch;
  final String logo;
  final String schoolCode;

  final Function(String value) onChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: const Color.fromARGB(255, 255, 252, 242),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: showSearch
            ? SizedBox(
                height: 34,
                child: TextField(
                  readOnly: readonly ?? false,
                  autofocus: autofocus ?? false,
                  onTap: onTap,
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
              )
            : null,
      ),
      actions: [
        ProfilePicWidget(
          profilePic: logo,
          schoolCode: schoolCode,
          size: 40,
        )
      ],
      actionsPadding: EdgeInsets.only(right: 15, top: 10, bottom: 5),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
