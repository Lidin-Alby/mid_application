// import 'package:flutter/material.dart';
// import 'package:mid_application/models/school.dart';
// import 'package:mid_application/widgets/my_filled_button.dart';
// import 'package:mid_application/widgets/my_textfield.dart';

// class EditSchool extends StatelessWidget {
//   const EditSchool({super.key, required this.school});
//   final School school;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 15,
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 5),
//                       child: CircleAvatar(
//                         radius: 40,
//                         backgroundImage:
//                             AssetImage('assets/images/logoImg.jpg'),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 3,
//                       right: -15,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(shape: CircleBorder()),
//                         child: Icon(Icons.add_a_photo_outlined),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Text(
//                 'Code : ${school.schoolCode}',
//                 style: TextStyle(color: Colors.grey[600]),
//               ),
//               MyTextfield(
//                 label: 'School Name',
//                 onChanged: (value) {
//                   value = 'fewf';
//                 },
//               ),
//               MyTextfield(
//                 label: 'Email',
//                 onChanged: (value) {
//                   value = 'fewf';
//                 },
//               ),
//               Row(
//                 spacing: 15,
//                 children: [
//                   Expanded(
//                     child: MyTextfield(
//                       label: 'Establishment Code',
//                       onChanged: (value) {},
//                     ),
//                   ),
//                   Expanded(
//                     child: MyTextfield(
//                       label: 'Affliation No.',
//                       onChanged: (value) {},
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Address',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   SizedBox(
//                     child: TextField(
//                       minLines: 3,
//                       maxLines: null,
//                       onChanged: (value) {},
//                       decoration: InputDecoration(
//                         isDense: true,
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.all(8),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 spacing: 15,
//                 children: [
//                   Expanded(
//                     child: MyTextfield(
//                       label: 'Pincode',
//                       onChanged: (value) {},
//                     ),
//                   ),
//                   Expanded(
//                     child: MyTextfield(
//                       label: 'School Phone',
//                       onChanged: (value) {},
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 spacing: 15,
//                 children: [
//                   Expanded(
//                     child: MyTextfield(
//                       label: 'Principal Name',
//                       onChanged: (value) {},
//                     ),
//                   ),
//                   Expanded(
//                     child: MyTextfield(
//                       label: 'Principal Phone',
//                       onChanged: (value) {},
//                     ),
//                   )
//                 ],
//               ),
//               MyTextfield(
//                 label: 'Website URL',
//                 onChanged: (value) {},
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 spacing: 20,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 30),
//                     child: Text(
//                       'Signature :',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                         height: 70,
//                         width: 180,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(right: 20, top: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             border: Border.all(color: Colors.grey)),
//                         child: Text(
//                           'Signature\nHere',
//                           style: TextStyle(color: Colors.grey),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Positioned(
//                         right: -10,
//                         top: -5,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style:
//                               ElevatedButton.styleFrom(shape: CircleBorder()),
//                           child: Icon(Icons.attach_file_rounded),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   MyFilledButton(
//                     label: 'Cancel',
//                     onPressed: () {},
//                   ),
//                   MyFilledButton(
//                     label: 'Save',
//                     onPressed: () {},
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
