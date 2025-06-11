import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonPage<T> extends StatelessWidget {
  const ButtonPage({
    super.key,
    required this.title,
    required this.initialValue,
    required this.value,
    this.onChanged,
  });
  final String title;
  final Function(T value)? onChanged;
  final T initialValue;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: onChanged != null ? () => onChanged!(initialValue) : null,
        minWidth: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 6),
            Text(title),
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: initialValue == value
                  ? onChanged != null
                        ? 1
                        : .5
                  : 0,
              child: Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                height: 4,
                color: Get.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
