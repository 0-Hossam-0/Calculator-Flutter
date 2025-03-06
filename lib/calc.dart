import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sizer/sizer.dart';
import 'package:calculator/button.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<List> buttons = [];
  bool isDarkMode = false;
  final TextEditingController _inputController = TextEditingController();
  @override
  void initState() {
    buttons = [
      ['C', _resetCalculate],
      [Icons.backspace_outlined, _removeNumber],
      ['%', () => _setNumber('%')],
      ['/', () => _setNumber('/'), Color(0xFF4b5efc)],
      ['7', () => _setNumber('7')],
      ['8', () => _setNumber('8')],
      ['9', () => _setNumber('9')],
      ['x', () => _setNumber('x'), Color(0xFF4b5efc)],
      ['4', () => _setNumber('4')],
      ['5', () => _setNumber('5')],
      ['6', () => _setNumber('6')],
      ['-', () => _setNumber('-'), Color(0xFF4b5efc)],
      ['1', () => _setNumber('1')],
      ['2', () => _setNumber('2')],
      ['3', () => _setNumber('3')],
      ['+', () => _setNumber('+'), Color(0xFF4b5efc)],
      ['0', () => _setNumber('0')],
      [Icons.dark_mode, _setIsDarkMode],
      ['.', () => _setNumber('.')],
      ['=', _evaluateExpression, Color(0xFF4b5efc)],
    ];
    _inputController.text = '0';
    super.initState();
  }

  void _setIsDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _setNumber(String number) {
    if (_inputController.text != 'Invalid') {
      if (_inputController.text == '0') {
        setState(() {
          _inputController.text = number;
        });
      } else {
        setState(() {
          _inputController.text = _inputController.text + number;
        });
      }
      _inputController.selection =
          TextSelection.collapsed(offset: _inputController.text.length);
    }
  }

  void _evaluateExpression() {
    if (_inputController.text.contains('x')) {
      _inputController.text = _inputController.text.replaceAll('x', '*');
    }
    try {
      Parser parse = Parser();
      Expression exp = parse.parse(_inputController.text);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        _inputController.text = result.toString();
      });
    } catch (e) {
      setState(() {
        _inputController.text = 'Invalid';
      });
    }
  }

  void _resetCalculate() {
    setState(() {
      _inputController.text = '0';
    });
  }

  void _removeNumber() {
    if (_inputController.text != 'Invalid') {
      if (_inputController.text.isNotEmpty) {
        setState(() {
          _inputController.text = _inputController.text
              .substring(0, _inputController.text.length - 1);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: isDarkMode ? Color(0xFF17171c) : Color.fromARGB(255, 236, 235, 235),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: isDarkMode ? Color(0xFF17171c) : Color.fromARGB(255, 236, 235, 235),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.4,
                alignment: Alignment.center,
                child: TextField(
                  controller: _inputController,
                  maxLines: 1,
                  readOnly: true,
                  minLines: null,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 34.sp),
                  textAlignVertical: TextAlignVertical.bottom,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    fillColor: isDarkMode ? Color(0xFF17171c) : Color.fromARGB(255, 226, 223, 223),
                    contentPadding: EdgeInsets.symmetric(vertical: 13.h),
                    filled: true,
                    border: InputBorder.none,
                  ),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.1,
                      mainAxisExtent: 9.h,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Button(
                      buttonName: buttons[index][0],
                      isDarkMode: isDarkMode,
                      handleFunctions: buttons[index][1],
                      color: (buttons[index].length > 2)
                          ? buttons[index][2]
                          : Color(0xFF4e505f),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
