import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/core/class/type_note.dart';

import '../../../controller/home_controller.dart';
import '../../../core/class/note.dart';

class BodyNote extends GetView<HomeController> {
  const BodyNote({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    Note note = controller.notes[index];
    switch (note.type) {
      case TypeNote.note:
        return Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                width: 20,
                color: Get.theme.colorScheme.inversePrimary,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            height: note.height,
            width: note.width,
            color: Get.theme.colorScheme.inversePrimary,
            child: Text(
              note.data,
              overflow: TextOverflow.ellipsis,
              maxLines: (note.height - 10) ~/ (14 * 1.4),
            ),
          ),
        );
      case TypeNote.imageAsset:
        return Container(
          height: note.height,
          width: note.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(note.data),
              fit: BoxFit.cover,
            ),
          ),
        );
      case TypeNote.image:
        return Container(
          height: note.height,
          width: note.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(note.data)),
              fit: BoxFit.cover,
            ),
          ),
        );
    }
  }
}
