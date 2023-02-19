import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meetingme/components/components.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class CreateAssignment extends StatefulWidget {
  CreateAssignment({
    Key? key,
    required this.titleCtrl,
    required this.descriptionCtrl,
    required this.marksCtrl,
    required this.subTimeCtrl,
  }) : super(key: key);

  final TextEditingController titleCtrl;
  final TextEditingController descriptionCtrl;
  final TextEditingController marksCtrl;
  final TextEditingController subTimeCtrl;

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setStateForDialog) {
                return AlertDialog(
                  scrollable: false,
                  content: Column(
                    children: [
                      TextField(
                        controller: widget.titleCtrl,
                        minLines: 1,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: normalTextInput.copyWith(
                            labelText: 'Assignment Title'),
                      ),
                      TextField(
                        controller: widget.descriptionCtrl,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5,
                        decoration:
                            normalTextInput.copyWith(labelText: 'Description'),
                      ),
                      TextField(
                        controller: widget.marksCtrl,
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration:
                            normalTextInput.copyWith(labelText: 'Marks'),
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onChanged: (time) => {
                              widget.subTimeCtrl.text =
                                  time.toLocal().toString(),
                            },
                          );
                        },
                        child: AbsorbPointer(
                            child: TextField(
                          controller: widget.subTimeCtrl,
                          decoration: normalTextInput.copyWith(
                              labelText: 'Submissition Time'),
                        )),
                      ),
                      WhiteDivider(),
                      ElevatedButton.icon(
                        onPressed: () async {
                          result = await FilePicker.platform
                              .pickFiles(allowMultiple: true);
                          if (result == null) {
                            print("No file selected");
                          } else {
                            setStateForDialog(() {});
                          }
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Attach Files'),
                      ),
                      const WhiteDivider(),
                      result == null
                          ? Container()
                          : Column(
                              children: [
                                const Text('Selected Files: '),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: result?.files.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Text(
                                          textAlign: TextAlign.center,
                                          result?.files[index].name ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold));
                                    }),
                              ],
                            ),
                      const WhiteDivider(),
                      ElevatedButton.icon(
                        onPressed: () {
                          print(result!.files.length);
                        },
                        label: const Text('Save'),
                        icon: const Icon(
                          Icons.save,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ConstantColors.createButtonColor),
                        ),
                      ),
                    ],
                  ),
                );
              });
            });
      },
      icon: const Icon(
        Icons.add,
      ),
      label: const Text('Create New'),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ConstantColors.createButtonColor),
      ),
    );
  }
}
