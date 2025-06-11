import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/note.dart';
import '../core/class/type_note.dart';
import '../data/sql/sql_db.dart';
import '../view/pages/add_note_dialog.dart';

class HomeController extends GetxController {
  bool isLoadig = true;
  List<Note> notes = [];
  SqlDB sqlDB = SqlDB();

  @override
  void onInit() {
    readData();
    super.onInit();
  }

  void moveNote(int index, Offset offset) {
    notes[index].move(offset);
    update();
  }

  void futureMoveNote(int index) {
    sqlDB.updateData(
      from: notesTABLE,
      setValues: {
        "offset_x": notes[index].offset.dx,
        "offset_y": notes[index].offset.dy,
      },
      where: 'id=${notes[index].id}',
    );
  }

  void editSizeNote(int index, Offset offset) {
    notes[index].editSize(offset.dx, offset.dy);
    update();
  }

  void futureEditSizeNote(int index) {
    sqlDB.updateData(
      from: notesTABLE,
      setValues: {"width": notes[index].width, "height": notes[index].height},
      where: 'id=${notes[index].id}',
    );
  }

  void readData() {
    try {
      sqlDB.readData(from: notesTABLE).then((List<Map<String, Object?>> value) {
        notes = value.map((e) => Note.toJson(e)).toList();
        isLoadig = false;
        update();
      });
    } catch (e) {
      print("Error Sql: $e");
    }
  }

  void addNote() {
    Get.dialog(
      AddNoteDialog(),
      arguments: (String data, TypeNote type, {Size? size}) {
        isLoadig = true;
        update();
        sqlDB.insertData(
          from: notesTABLE,
          intoValues: {
            "data": data,
            "type": type.name,
            "offset_x": 50.0,
            "offset_y": 50.0,
            "width": size?.width ?? 300.0,
            "height": size?.height ?? 180.0,
          },
        );
        readData();
      },
    );
  }

  void editNote(int index, String value) {
    isLoadig = true;
    update();
    if (value == "Delete") {
      sqlDB.deleteData(from: notesTABLE, where: 'id=${notes[index].id}');
      readData();
    } else if (value == "Edit") {
      switch (notes[index].type) {
        case TypeNote.note:
          break;
        case TypeNote.image:
          break;
        case TypeNote.imageAsset:
          break;
      }
      isLoadig = false;
      update();
    }
  }
}
