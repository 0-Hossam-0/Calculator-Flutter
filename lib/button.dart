import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Button extends StatelessWidget {
  final dynamic buttonName;
  final Function() handleFunctions;
  final Color color;
  final bool isDarkMode;
  const Button({
    super.key,
    required this.buttonName,
    required this.handleFunctions,
    required this.color,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleFunctions,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
        backgroundColor: WidgetStatePropertyAll<Color>(
          isDarkMode || color != Color(0xFF4e505f)
              ? color
              : Color.fromARGB(255, 211, 209, 209),
        ),
      ),
      child: buttonName.runtimeType == String
          ? Text(
              buttonName,
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : color == Color(0xFF4b5efc)
                        ? Colors.white
                        : Colors.black,
                fontSize: 24.sp,
              ),
            )
          : Icon(
              buttonName,
              size: 25.sp,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
    );
  }
}
