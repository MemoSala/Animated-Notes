import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../../../core/class/type_note.dart';

class ButtonMore extends GetView<HomeController> {
  const ButtonMore({super.key, required this.onSelected, required this.type});
  final Function(String value) onSelected;
  final TypeNote type;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2.5,
      right: 2.5,
      child: CircleAvatar(
        backgroundColor: Get.theme.colorScheme.primary.withAlpha(127),
        radius: 12.5,
        child: PopupMenuButton<String>(
          padding: EdgeInsetsGeometry.all(0),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(value: "Delete", child: Text("Delete")),
            if (type != TypeNote.imageAsset)
              PopupMenuItem(value: "Edit", child: Text("Edit")),
          ],
          child: Icon(Icons.more_vert, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}
