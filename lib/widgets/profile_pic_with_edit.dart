import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_bloc.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_event.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_state.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class ProfilePicWithEdit extends StatelessWidget {
  const ProfilePicWithEdit(
      {super.key,
      required this.userType,
      required this.userId,
      required this.imageUrl,
      required this.fullName,
      required this.schoolCode,
      required this.oldProfilePic});
  final String userType;
  final String userId;
  final String imageUrl;
  final String fullName;
  final String schoolCode;
  final String? oldProfilePic;

  @override
  Widget build(BuildContext context) {
    String url = imageUrl;
    return BlocConsumer<ProfilePicBloc, ProfilePicState>(
      listener: (context, state) {
        if (state is ProfilePicUploadError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: ProfilePicWidget(
              size: 80,
              imageUrl: url,
            ),
          ),
          if (state is ProfilePicUploading)
            Positioned(
              top: 42,
              left: 43,
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(),
              ),
            ),
          Positioned(
            bottom: 3,
            right: -15,
            child: ElevatedButton(
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Profile Photo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton.outlined(
                                onPressed: () {
                                  context.read<ProfilePicBloc>().add(
                                        PickAndUploadProfilePicEvent(
                                          userType: userType,
                                          userId: userId,
                                          sourceType: ImageSource.camera,
                                          fullName: fullName,
                                          schoolCode: schoolCode,
                                          oldProfilePic: oldProfilePic,
                                        ),
                                      );
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.camera_alt),
                              ),
                              Text('Camera')
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton.outlined(
                                onPressed: () async {
                                  // pickImg(ImageSource.gallery);
                                },
                                icon: Icon(Icons.photo_library),
                              ),
                              Text('Pick Photo')
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
