// ignore_for_file: file_names

import 'dart:ui';

import 'package:get/get.dart';

import 'type_note.dart';

class Note {
  final int id;
  Offset _offset;
  final String data;
  Size _size;
  final TypeNote type;

  Note({
    required this.id,
    required Size size,
    this.data = "",
    this.type = TypeNote.note,
    Offset offset = const Offset(0, 0),
  }) : _size = size,
       _offset = Offset(
         _helpForOffset(offset.dx, Get.size.width, size.width),
         _helpForOffset(offset.dy, Get.size.height, size.height),
       );

  Note.toJson(Map<String, Object?> json)
    : id = json["id"] as int,
      data = json["data"] is String ? json["data"] as String : "",
      type = TypeNote.values.firstWhere(
        (e) => e.name == json["type"],
        orElse: () => TypeNote.note,
      ),
      _offset = Offset(
        json["offset_x"] is double ? json["offset_x"] as double : 0,
        json["offset_y"] is double ? json["offset_y"] as double : 0,
      ),
      _size = Size(
        json["width"] is double ? json["width"] as double : 300,
        json["height"] is double ? json["height"] as double : 180,
      );

  double get height => _size.height;
  double get width => _size.width;
  void editSize(double width, double height) {
    _size = Size(_size.width + width, _size.height + height);
    _size = Size(
      _size.width < 140 ? 140 : _size.width,
      _size.height < 100 ? 100 : _size.height,
    );
  }

  Offset get offset => _offset;

  void move(Offset delta) {
    Size sizeApp = Get.size;
    _offset += delta;
    _offset = Offset(
      _helpForOffset(_offset.dx, sizeApp.width, _width),
      _helpForOffset(_offset.dy, sizeApp.height, height),
    );
  }

  double get _width {
    switch (type) {
      case TypeNote.note:
        return width + 40;
      default:
        return width;
    }
  }
}

double _helpForOffset(double offset, double sizeApp, double sizeNote) =>
    offset <= 0 && offset < 0
    ? 0
    : offset >= sizeApp - sizeNote && offset >= 0
    ? sizeApp - sizeNote
    : offset;
