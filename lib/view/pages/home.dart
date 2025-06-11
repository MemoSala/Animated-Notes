import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../widget/home/body_note.dart';
import '../widget/home/button_more.dart';
import '../widget/home/diagonal_lines_icon.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => Stack(
          children: [
            for (int i = 0; i < controller.notes.length; i++)
              Positioned(
                left: controller.notes[i].offset.dx,
                top: controller.notes[i].offset.dy,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Draggable(
                      onDragUpdate: (details) =>
                          controller.moveNote(i, details.delta),
                      onDragEnd: (details) => controller.futureMoveNote(i),
                      feedback: const SizedBox(),
                      child: BodyNote(index: i),
                    ),
                    Draggable(
                      onDragUpdate: (details) =>
                          controller.editSizeNote(i, details.delta),
                      onDragEnd: (details) => controller.futureEditSizeNote(i),
                      feedback: const SizedBox(),
                      child: const DiagonalLinesIcon(),
                    ),
                    ButtonMore(
                      onSelected: (value) => controller.editNote(i, value),
                      type: controller.notes[i].type,
                    ),
                  ],
                ),
              ),
            if (controller.isLoadig)
              Container(
                color: Colors.white54,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
