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

class Arithmetic extends StatefulWidget {
  @override
  _CalculatorNeuAppState createState() => _CalculatorNeuAppState();
}

class _CalculatorNeuAppState extends State<Arithmetic> {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   '=',
                        //   style: TextStyle(
                        //       fontSize: 35,
                        //       color: darkMode ? Colors.green : Colors.grey),
                        // ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'scientific');
                          },
                          child: Text(
                            '=',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 30,
                                color: darkMode ? Colors.green : Colors.grey),
                          ),
                        ),


                        Text(
                          '${expression}',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 20,
                              color: darkMode ? Colors.green : Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'matrix');
                          },
                          child: Text(
                            '[  ]',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                color: darkMode ? Colors.green : Colors.grey),
                          ),
                        ),
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
                      // _buttonOval(title: 'sin'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryFunc("sin");
                            });
                          },
                          child: _buttonOval(title: 'sin')),

                      // _buttonOval(title: 'cos'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryFunc("cos");
                            });
                          },
                          child: _buttonOval(title: 'cos')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryFunc("tan");
                            });
                          },
                          child: _buttonOval(title: 'tan')),

                      // _buttonOval(title: 'tan'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screenUpdate("%");
                            });
                          },
                          child: _buttonOval(title: '%'))
                      // _buttonOval(title: '%')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            screen = "";
                            expression = "";
                            ispoint = true;
                          });
                        },
                        child: _buttonRounded(
                            title: 'C',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "(";
                              expression+="(";
                            });
                          },
                          child: _buttonRounded(title: '(')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += ")";
                              expression+=")";
                            });
                          },
                          child: _buttonRounded(title: ')')),

                      // _buttonRounded(title: '('),
                      // _buttonRounded(title: ')'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screenUpdate("/");
                            });
                          },
                          child: _buttonRounded(
                              title: '/',
                              textColor:
                                  darkMode ? Colors.green : Colors.redAccent)),
                      // _buttonRounded(
                      //     title: '/',
                      //     textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "7";
                              expression+="7";
                            });
                          },
                          child: _buttonRounded(title: '7')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "8";
                              expression+="8";
                            });
                          },
                          child: _buttonRounded(title: '8')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "9";
                              expression+="9";
                            });
                          },
                          child: _buttonRounded(title: '9')),
                      // _buttonRounded(title: '7'),
                      // _buttonRounded(title: '8'),
                      // _buttonRounded(title: '9'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screenUpdate("*");
                            });
                          },
                          child: _buttonRounded(
                              title: 'X',
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
                              expression+="4";
                            });
                          },
                          child: _buttonRounded(title: '4')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "5";
                              expression+="5";
                            });
                          },
                          child: _buttonRounded(title: '5')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "6";
                              expression+="6";
                            });
                          },
                          child: _buttonRounded(title: '6')),
                      // _buttonRounded(title: '4'),
                      // _buttonRounded(title: '5'),
                      // _buttonRounded(title: '6'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screenUpdate("-");
                            });
                          },
                          child: _buttonRounded(
                              title: '-',
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
                              expression+="1";
                            });
                          },
                          child: _buttonRounded(title: '1')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "2";
                              expression+="2";
                            });
                          },
                          child: _buttonRounded(title: '2')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen += "3";
                              expression+="3";
                            });
                          },
                          child: _buttonRounded(title: '3')),
                      // _buttonRounded(title: '2'),
                      // _buttonRounded(title: '3'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screenUpdate("+");
                            });
                          },
                          child: _buttonRounded(
                              title: '+',
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
                              expression+="0";
                            });
                          },
                          child: _buttonRounded(title: '0')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (ispoint) {
                                screen += ".";
                                expression+=".";
                                ispoint = false;
                              }
                            });
                          },
                          child: _buttonRounded(title: '.')),
                      // _buttonRounded(title: '0'),
                      // _buttonRounded(title: '.'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              screen = screen.substring(0, screen.length - 1);
                              expression = expression.substring(0,expression.length - 1);
                              if (screen.length == 0) {
                                ispoint = true;
                              }
                            });
                          },
                          child: _buttonRounded(
                              icon: Icons.backspace_outlined,
                              iconColor:
                                  darkMode ? Colors.green : Colors.redAccent)),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              // screen = eval(screen).toString();
                              Expression exp = Expression(screen);
                              screen = exp.eval().toString();
                            });
                          },
                          child: _buttonRounded(
                              title: '=',
                              textColor:
                                  darkMode ? Colors.green : Colors.redAccent))
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
    // expression += screen;
    // screen = eval(screen).toString();
    Expression exp = Expression(screen);
    screen = exp.eval().toString();
    screen += operator;

    expression+=operator;
  } else {
    screen = screen.substring(0, screen.length - 1);
    screen += operator;
    expression = expression.substring(0, expression.length - 1);
    expression+=operator;
  }
}

void trigonomatryFunc(String func) {
  String temp = "";
  String expTmp = "";
  expTmp = expression;

  if (func == "sin") {
    temp = Expression("SIN($screen)").eval().toString();
    screen = temp.substring(0, 10);
    expression="";
    expression+="sin(";
    expression+=expTmp;
    expression+=")";
  } else if (func == "cos") {
    temp = Expression("COS($screen)").eval().toString();
    screen = temp.substring(0, 10);
    expression="";
    expression+="cos(";
    expression+=expTmp;
    expression+=")";
  } else if (func == "tan") {
    if (screen == "90" || screen == "270") {
      screen = "Infinity";
      return;
    }
    temp = Expression("TAN($screen)").eval().toString();
    screen = temp.substring(0, 10);
    expression="";
    expression+="tan(";
    expression+=expTmp;
    expression+=")";
  }
}
