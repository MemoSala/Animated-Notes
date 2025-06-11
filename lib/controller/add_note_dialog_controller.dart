import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

import '../core/class/type_note.dart';

class AddNoteDialogController extends GetxController {
  bool isLoading = false;

  final GlobalKey<FormState> static = GlobalKey();
  final TextEditingController data = TextEditingController();
  final PageController page = PageController();
  TypeNote type = TypeNote.note;
  Offset offset = const Offset(0, 0);
  String? image;

  void editType(TypeNote newType) {
    type = newType;
    page.animateToPage(
      newType.index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    update();
  }

  void addImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      this.image = image.path;
      update();
    }
  }

  void add() async {
    isLoading = true;
    update();
    switch (type) {
      case TypeNote.note:
        Get.arguments(data.text, type);
        break;
      case TypeNote.image:
        if (image != null) {
          Size? size;
          try {
            final Uint8List bytes = await File(this.image!).readAsBytes();
            img.Image? image = img.decodeImage(bytes);
            if (image != null) {
              double width = math.sqrt(300 * 180 * image.width / image.height);
              double height = 300 * 180 / width;
              size = Size(width, height);
            }
          } catch (e) {
            null;
          }
          Get.arguments(image, type, size: size);
        }
        break;
      case TypeNote.imageAsset:
        Get.arguments("assets/images/photo.jpeg", type);
        break;
    }
    isLoading = false;
    update();
    Get.back();
  }
}
