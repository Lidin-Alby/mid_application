import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormSettingsTile extends StatelessWidget {
  const FormSettingsTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.description,
      required this.onTap,
      required this.value});
  final String title;
  final IconData icon;
  final String description;
  final bool value;
  final Function(bool value) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: GoogleFonts.inter(fontSize: 10),
              ),
              // Spacer(),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.4,
                    color: Color.fromARGB(61, 0, 0, 0),
                  ),
                ]),
            child: InkWell(
              onTap: () {
                onTap(!value);
              },
              child: Ink(
                width: 28,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment:
                      value ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: value
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        value ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
