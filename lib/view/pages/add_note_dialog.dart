import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show ImageSource;

import '../../controller/add_note_dialog_controller.dart';
import '../../core/class/type_note.dart';
import '../widget/add_note_dialog/button_page.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    AddNoteDialogController controller = Get.put(AddNoteDialogController());
    return SimpleDialog(
      title: Text("Add new Note"),
      contentPadding: EdgeInsetsGeometry.only(
        top: 10,
        bottom: 20,
        right: 20,
        left: 20,
      ),
      children: [
        SizedBox(
          width: 300,
          child: GetBuilder<AddNoteDialogController>(
            builder: (controller) {
              return Row(
                children: <ButtonPage<TypeNote>>[
                  ButtonPage<TypeNote>(
                    title: "Note",
                    initialValue: TypeNote.note,
                    value: controller.type,
                    onChanged: controller.editType,
                  ),
                  ButtonPage<TypeNote>(
                    title: "Image",
                    initialValue: TypeNote.image,
                    value: controller.type,
                    onChanged: controller.editType,
                  ),
                  ButtonPage<TypeNote>(
                    title: "Good Image",
                    initialValue: TypeNote.imageAsset,
                    value: controller.type,
                    onChanged: controller.editType,
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(
          width: 300,
          height: 100,
          child: Form(
            key: controller.static,
            child: GetBuilder<AddNoteDialogController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return PageView(
                  controller: controller.page,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextField(
                      controller: controller.data,
                      maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Data",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () =>
                              controller.addImage(ImageSource.camera),
                          iconSize: 40,
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.all(10),
                          height: 80,
                          width: controller.image != null ? 100 : 0,
                          decoration: BoxDecoration(
                            image: controller.image != null
                                ? DecorationImage(
                                    image: FileImage(File(controller.image!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              controller.addImage(ImageSource.gallery),
                          iconSize: 40,
                          icon: Icon(Icons.folder),
                        ),
                      ],
                    ),
                    Center(child: Text("Add a good image 😜")),
                  ],
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: Get.back, child: Text("Cancel")),
            TextButton(onPressed: controller.add, child: Text("Add")),
          ],
        ),
      ],
    );
  }
}
