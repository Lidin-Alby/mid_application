import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.cardColor,
    this.color,
    required this.onTap,
    required this.showBadge,
  });
  final IconData icon;
  final String label;
  final String count;
  final Color cardColor;
  final Color? color;
  final VoidCallback onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 2,
              color: const Color.fromARGB(60, 0, 0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(6),
              ),
              height: 130,
              width: 130,
              // alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Icon(
                          icon,
                          size: 20,
                          color: color,
                        ),
                        Text(
                          count,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: color,
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, right: 6),
                      child: showBadge
                          ? Icon(
                              Icons.circle,
                              color: Theme.of(context).colorScheme.primary,
                              size: 10,
                            )
                          : SizedBox(
                              width: 10,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
