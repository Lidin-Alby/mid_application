import 'package:flutter/material.dart';

class MidTile extends StatelessWidget {
  const MidTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.color,
      required this.callback,
      this.count = -1});
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback callback;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          // Stack(
          //   fit: StackFit.passthrough,
          //   children: [
          Card.filled(
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
          child: InkWell(
            onTap: callback,
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border(
              //     bottom: BorderSide(width: 6, color: color),
              //   ),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  // runSpacing: 15,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  // alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        icon,
                        size: 30,
                      ),
                    ),
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //   if (count != null)
      //     Positioned(
      //       right: 2,
      //       child: Card(
      //         child: Container(
      //             alignment: Alignment.center,
      //             width: 35,
      //             height: 35,
      //             // padding: EdgeInsets.all(2),
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 border: Border.all(color: Colors.indigo, width: 2),
      //                 borderRadius: BorderRadius.circular(20)),
      //             child: Text(
      //               count!,
      //               style: TextStyle(fontSize: 12),
      //             )),
      //       ),
      //     )
      // ],
      // ),
    );
  }
}
