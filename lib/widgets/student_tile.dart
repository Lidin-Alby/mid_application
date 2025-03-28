import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mid_application/Screens/student_details_screen.dart';
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/student.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({super.key, required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDetailsScreen(
              schoolCode: student.schoolCode,
              admNo: student.admNo,
            ),
          ),
        );
      },
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '$ipv4/getPic/${student.schoolCode}/${student.profilePic}',
                        imageBuilder: (context, imageProvider) => Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '$ipv4/getPic/${student.schoolCode}/${student.profilePic}'),
                            ),
                          ),
                        ),
                        placeholder: (context, imageUrl) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, imageUrl, error) => Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/logoImg.jpg'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.fullName.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Student',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 37,
                        child: Text(
                          'Father',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        student.fatherName.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 37,
                        child: Text(
                          'Mother',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        student.motherName.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 37,
                        child: Text(
                          'Mobile',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        student.fatherMobNo.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'DOB : ',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        student.dob.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.admNo,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Admission No.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   width: 25,
              // ),
              // Spacer(),
              // if (student.check ?? false)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
