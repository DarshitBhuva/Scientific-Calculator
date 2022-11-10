import 'package:dart_eval/stdlib/core.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';
import 'dart:math';
import 'package:eval_ex/eval_ex.dart';

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

String screen = "";
String expression = "";
String lastOperator = "";
bool ispoint = true;

class Matrix extends StatefulWidget {
  @override
  _CalculatorNeuAppState createState() => _CalculatorNeuAppState();
}

class _CalculatorNeuAppState extends State<Matrix> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            darkMode ? darkMode = false : darkMode = true;
                          });
                        },
                        child: _switchMode()),
                    SizedBox(height: 120),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${screen}',
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: darkMode ? Colors.white : Colors.red),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'home');
                          },
                          child: Text(
                            '=',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 30,
                                color: darkMode ? Colors.green : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   '=',
                        //   style: TextStyle(
                        //       fontSize: 35,
                        //       color: darkMode ? Colors.green : Colors.grey),
                        // ),

                        TextButton(
                            onPressed: () {
                              setState(() {
                                MatrixTrapnspose();
                              });
                            },
                            child:
                                _buttonOval(title: '[  ]\u1d40', padding: 22)),

                        TextButton(
                            onPressed: () {
                              setState(() {
                                AddNewMatrix();
                              });
                            },
                            child: _buttonOval(title: 'Add [  ]', padding: 15)),

                        TextButton(
                            onPressed: () {
                              setState(() {
                                PerformOperation("+");
                              });
                            },
                            child: _buttonOval(title: '[+]', padding: 15)),

                        TextButton(
                            onPressed: () {
                              setState(() {
                                PerformOperation("-");
                              });
                            },
                            child: _buttonOval(title: '[-]', padding: 15)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "7";
                            });
                          },
                          child: _buttonRounded(title: '7')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "8";
                            });
                          },
                          child: _buttonRounded(title: '8')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "9";
                            });
                          },
                          child: _buttonRounded(title: '9')),
                      // _buttonRounded(title: '7'),
                      // _buttonRounded(title: '8'),
                      // _buttonRounded(title: '9'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += ' ';
                            });
                          },
                          child: _buttonRounded(
                              title: '_',
                              textColor:
                                  darkMode ? Colors.green : Colors.redAccent)),

                      // _buttonRounded(
                      //     title: 'x',
                      //     textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "4";
                            });
                          },
                          child: _buttonRounded(title: '4')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "5";
                            });
                          },
                          child: _buttonRounded(title: '5')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "6";
                            });
                          },
                          child: _buttonRounded(title: '6')),
                      // _buttonRounded(title: '4'),
                      // _buttonRounded(title: '5'),
                      // _buttonRounded(title: '6'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "\n";
                            });
                          },
                          child: _buttonRounded(
                              title: "<-",
                              textColor:
                                  darkMode ? Colors.green : Colors.redAccent)),
                      // _buttonRounded(
                      //     title: '-',
                      //     textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "1";
                            });
                          },
                          child: _buttonRounded(title: '1')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "2";
                            });
                          },
                          child: _buttonRounded(title: '2')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "3";
                            });
                          },
                          child: _buttonRounded(title: '3')),
                      // _buttonRounded(title: '2'),
                      // _buttonRounded(title: '3'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen = "";
                            });
                          },
                          child: _buttonRounded(
                              title: 'C',
                              textColor:
                                  darkMode ? Colors.green : Colors.redAccent))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "0";
                            });
                          },
                          child: _buttonRounded(title: '0')),
                      // TextButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         if (ispoint) {
                      //           screen += ".";
                      //           ispoint = false;
                      //         }
                      //       });
                      //     },
                      //     child: _buttonRounded(title: '.')),
                      // _buttonRounded(title: '0'),
                      // _buttonRounded(title: '.'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen = screen.substring(0, screen.length - 1);
                              if (screen.length == 0) {
                                ispoint = true;
                              }
                            });
                          },
                          child: _buttonRounded(
                              icon: Icons.backspace_outlined,
                              iconColor:
                                  darkMode ? Colors.green : Colors.redAccent)),

                      // TextButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         screen = eval(screen).toString();
                      //       });
                      //     },
                      //     child: _buttonRounded(
                      //         title: '=',
                      //         textColor:
                      //             darkMode ? Colors.green : Colors.redAccent))
                      // _buttonRounded(
                      //     title: '=',
                      //     textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonRounded(
      {String? title,
      double padding = 15,
      IconData? icon,
      Color? iconColor,
      Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: NeuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(40),
        padding: EdgeInsets.all(padding),
        child: Container(
          width: padding * 2,
          height: padding * 2,
          child: Center(
              child: title != null
                  ? Text(
                      '$title',
                      style: TextStyle(
                          color: textColor != null
                              ? textColor
                              : darkMode
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 27),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 30,
                    )),
        ),
      ),
    );
  }

  Widget _buttonOval({String? title, double padding = 17}) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: NeuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(50),
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: SingleChildScrollView(
          //width: padding * 1.9,
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.wb_sunny,
            color: darkMode ? Colors.grey : Colors.redAccent,
          ),
          Icon(
            Icons.nightlight_round,
            color: darkMode ? Colors.green : Colors.grey,
          ),
        ]),
      ),
    );
  }
}

class NeuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  NeuContainer(
      {this.darkMode = false, this.child, this.borderRadius, this.padding});

  @override
  _NeuContainerState createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            color: darkMode ? colorDark : colorLight,
            borderRadius: widget.borderRadius,
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      color:
                          darkMode ? Colors.black54 : Colors.blueGrey.shade200,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                        color:
                            darkMode ? Colors.blueGrey.shade700 : Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0)
                  ]),
        child: widget.child,
      ),
    );
  }
}

void makeMatrix() {
  //List<List<int>> matrix = [[]];

  var matrix = List.generate(5, (index) => List.filled(5, 1256));

  int row = 0, col = 0;
  int num = 0;
  String temp = "";
  int n = screen.length;

  // for(int i=0; i<n; i++)
  //  {
  //    if(screen[i] != '\n')
  //        print(screen[i]);
  //  }

  for (int i = 0; i < screen.length; i++) {
    if (screen[i] == '\n') {
      // print(temp);
      num = int.parse(temp.trim());
      matrix[row][col] = num;
      // matrix[row].add(num);
      row++;
      col = 0;
      temp = "";
      //  print("first");

    } else if (screen[i] == ' ') {
      //print(temp);
      num = int.parse(temp.trim());
      matrix[row][col] = num;
      // matrix[row].add(num);
      col++;
      temp = "";
      //print("second");
    } else if (screen[i] != ' ') {
      temp += screen[i];
      // print(temp);
    }
  }

  //print(temp);
  num = int.parse(temp.trim());
  matrix[row][col] = num;
  // matrix[row].add(num);

  screen = "";
  for (int i = 0; i < matrix[0].length; i++) {
    for (int j = 0; j < matrix.length; j++) {
      if (matrix[j][i] != 1256)
        screen += matrix[j][i].toString() + " ";

    }

    screen += "\n";
  }

  screen = screen.trim();
}

void MatrixTrapnspose() {
  makeMatrix();
}

bool isOperator() {
  int n = screen.length;
  if (screen[n - 1] == '+' ||
      screen[n - 1] == '-' ||
      screen[n - 1] == '*' ||
      screen[n - 1] == '/' ||
      screen[n - 1] == '%') {
    return false;
  }
  return true;
}

void screenUpdate(String operator) {
  if (screen.length > 0 && isOperator()) {
    expression += screen;
    screen = eval(screen).toString();
    screen += operator;
    expression += operator;
  } else {
    screen = screen.substring(0, screen.length - 1);
    screen += operator;
    expression = expression.substring(0, expression.length - 1);
    expression += operator;
  }
}

var matrix1 = List.generate(5, (index) => List.filled(5, 1256, growable: true),
    growable: true);
var matrix2 = List.generate(5, (index) => List.filled(5, 1256, growable: true),
    growable: true);

void AddNewMatrix() {
  int row = 0, col = 0;
  int num = 0;
  String temp = "";
  int n = screen.length;

  for (int i = 0; i < screen.length; i++) {
    if (screen[i] == '\n') {
      num = int.parse(temp.trim());
      matrix1[row][col] = num;

      row++;
      col = 0;
      temp = "";
    } else if (screen[i] == ' ') {
      num = int.parse(temp.trim());
      matrix1[row][col] = num;

      col++;
      temp = "";
    } else if (screen[i] != ' ') {
      temp += screen[i];
    }
  }

  //print(temp);
  num = int.parse(temp.trim());
  matrix1[row][col] = num;
  // matrix[row].add(num);
  screen = "";
}

void PerformOperation(String op) {
  int row = 0, col = 0;
  int num = 0;
  String temp = "";
  int n = screen.length;

  for (int i = 0; i < screen.length; i++) {
    if (screen[i] == '\n') {
      num = int.parse(temp.trim());
      matrix2[row][col] = num;

      row++;
      col = 0;
      temp = "";
    } else if (screen[i] == ' ') {
      num = int.parse(temp.trim());
      matrix2[row][col] = num;

      col++;
      temp = "";
    } else if (screen[i] != ' ') {
      temp += screen[i];
    }
  }

  //print(temp);
  num = int.parse(temp.trim());
  matrix2[row][col] = num;
  // matrix[row].add(num);

  screen = "";
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      if (matrix1[i][j] != 1256 && matrix2[i][j] != 1256) {
        if (op == "+") {
          int sum = matrix1[i][j] + matrix2[i][j];
          screen += sum.toString() + " ";

        } else {
          int sub = matrix1[i][j] - matrix2[i][j];
          screen += sub.toString() + " ";
        }

        matrix1[i][j] = 1256;
        matrix2[i][j] = 1256;
      }
    }
    screen += "\n";
  }
  screen = screen.trim();
}
