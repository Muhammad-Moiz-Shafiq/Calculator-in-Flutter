import 'package:calculator/MyButtons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorUi extends StatefulWidget {
  const CalculatorUi({super.key});

  @override
  State<CalculatorUi> createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  bool isOperator(String text) {
    if ('Cx/%-+'.split('').contains(text) || text == 'DEL') return true;
    return false;
  }

  void evaluation() {
    String finalQuestion = userInput;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    evaluatedOutput = exp.evaluate(EvaluationType.REAL, cm).toString();
  }

  String userInput = '', evaluatedOutput = '0';
  List<String> buttonTexts = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 25),
                  child: Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      userInput,
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    alignment: FractionalOffset.centerRight,
                    child: Text(
                      evaluatedOutput,
                      style:
                          TextStyle(color: Colors.orangeAccent, fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              shrinkWrap:
                  true, // Makes the GridView fit within the available space
              physics: NeverScrollableScrollPhysics(), // Prevents scrolling
              itemCount: buttonTexts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio:
                    1.1, // Adjusts the aspect ratio of the buttons
              ),
              itemBuilder: (BuildContext context, int index) {
                return AspectRatio(
                  aspectRatio: 1.0,
                  child: Mybutton(
                    buttonColor: index == buttonTexts.length - 1
                        ? Colors.deepOrangeAccent
                        : Colors.white12,
                    buttonText: buttonTexts[index],
                    textColor: isOperator(buttonTexts[index])
                        ? Colors.orangeAccent
                        : Colors.white,
                    onPressed: () {
                      setState(() {
                        if (index == 0) {
                          userInput = '';
                          evaluatedOutput = '0';
                        } else if (index == 1) {
                          if (userInput.isNotEmpty) {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          }
                        } else if (index == buttonTexts.length - 1) {
                          evaluation();
                        } else {
                          userInput += buttonTexts[index];
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
