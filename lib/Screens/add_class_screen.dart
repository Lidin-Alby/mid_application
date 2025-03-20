import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class/class_bloc.dart';
import 'package:mid_application/Blocs/Class/class_event.dart';
import 'package:mid_application/Blocs/Class/class_state.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/widgets/class_tile.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  TextEditingController className = TextEditingController();
  TextEditingController section = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ClassBloc>(context).add(LoadClasses(widget.schoolCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Class'),
      ),
      body: BlocConsumer<ClassBloc, ClassState>(
        listener: (context, state) {
          if (state is ClassAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added Succesfully')),
            );
            className.clear();
            section.clear();
          } else if (state is AddClassError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  MyTextfield(
                    label: 'Class/Department',
                    controller: className,
                  ),
                  MyTextfield(
                    label: 'Section',
                    controller: section,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  state is AddClassLoading
                      ? CircularProgressIndicator()
                      : Row(
                          children: [
                            Expanded(
                              child: MyFilledButton(
                                label: 'Save',
                                onPressed: () {
                                  BlocProvider.of<ClassBloc>(context).add(
                                    SaveClassPressed(
                                      className: className.text.trim(),
                                      section: section.text.trim(),
                                      schoolCode: widget.schoolCode,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 5,
            ),
            Expanded(
              child:
                  BlocBuilder<ClassBloc, ClassState>(builder: (context, state) {
                if (state is ClassError) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is ClassLoaded) {
                  List<ClassModel> classes = state.classes;
                  return classes.isEmpty
                      ? Text('No class added')
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(25, 20, 25, 40),
                          itemCount: classes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ClassTile(
                                classTitle: classes[index].classTitle,
                                totalStudents:
                                    classes[index].totalStudents.toString(),
                              ),
                            );
                          },
                        );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
