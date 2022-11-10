import 'package:calc/matrix.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';
import 'dart:math';
import 'dart:ui';
import 'package:eval_ex/eval_ex.dart';

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

String screen = "";
String expression = "";
String lastOperator = "";
bool ispoint = true;

// to find bth root of a
int a = 0, b = 0;
bool isfirstTime = true;
bool isnthroot = false;

class Scientific extends StatefulWidget {
  @override
  _CalculatorNeuAppState createState() => _CalculatorNeuAppState();
}

class _CalculatorNeuAppState extends State<Scientific> {
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
                    SizedBox(height: 60),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${screen}',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: darkMode ? Colors.white : Colors.red),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          '${expression}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
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
                              trigonomatryFunc("cot");
                            });
                          },
                          child: _buttonOval(title: 'cot', padding: 17)),

                      // _buttonOval(title: 'cos'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryInverseFunc("CosInv");
                            });
                          },
                          child: _buttonOval(
                              title: 'cos\u207B\u00B9', padding: 17)),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryInverseFunc("SinInv");
                            });
                          },
                          child: _buttonOval(
                              title: 'sin\u207B\u00B9', padding: 17)),

                      // _buttonOval(title: 'tan'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryInverseFunc("TanInv");
                            });
                          },
                          child: _buttonOval(
                              title: 'tan\u207B\u00B9', padding: 17)),

                      // _buttonOval(title: '%')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // _buttonOval(title: 'sin'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              trigonomatryInverseFunc("CotInv");
                            });
                          },
                          child: _buttonOval(
                              title: 'cot\u207B\u00B9')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              double x = double.parse(screen);
                              screen = (log(x) / log(10))
                                  .toString()
                                  .substring(0, 10);

                              String expTmp;
                              expTmp = expression;
                              expression = "";
                              expression+="log(";
                              expression+=expTmp;
                              expression+=")";
                            });
                          },
                          child: _buttonOval(title: 'log')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              double x = double.parse(screen);

                              x = x * x;
                              String tmp = expression;
                              expression+="*";
                              expression+=tmp;

                              handleDecimals(x);
                            });
                          },
                          child: _buttonOval(title: 'X\u00B2')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              double x = double.parse(screen);
                              x = sqrt(x);

                              handleDecimals(x);
                            });
                          },
                          child: _buttonOval(title: 'sqrt')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // _buttonOval(title: 'sin'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              XrestoY();
                            });
                          },
                          child: _buttonOval(title: 'X\u02b8', padding: 20)),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              findFactorial(screen);
                            });
                          },
                          child: _buttonOval(title: 'n!')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              fibonacci();
                            });
                          },
                          child: _buttonOval(title: 'fib')),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              isnthroot = true;
                              nthRoot();
                            });
                          },
                          child: _buttonOval(title: '\u207f\u221AX')),
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
                              if (isnthroot == true) {
                                isnthroot = false;
                                nthRoot();
                              } else {
                                Expression exp = Expression(screen);
                                String ans = exp.eval().toString();
                                if (ans.length > 13)
                                  screen = ans.substring(0, 13);
                                else
                                  screen = ans;
                              }
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
                          fontSize: 15),
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
      padding: const EdgeInsets.all(0),
      child: NeuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(50),
        padding:
            EdgeInsets.symmetric(horizontal: padding/1.1, vertical: padding / 2),
        child: SingleChildScrollView(
          // width: padding * 1.9,
          child: Center(

            child: Text(
              '$title',
              style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 16,
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
      screen[n - 1] == '%' ||
      screen[n - 1] == '^' ||
      screen[n - 1] == '\u221A') {
    return false;
  }
  return true;
}

void screenUpdate(String operator) {
  if (screen.length > 0 && isOperator()) {
    screen = eval(screen).toString();
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

  if (func == "cot") {
    if (screen == "0" || screen == "180") {
      screen = "Infinity";
      return;
    }
    temp = Expression("COT($screen)").eval().toString();
    screen = temp.substring(0, 10);
    expression="";
    expression+="cot(";
    expression+=expTmp;
    expression+=")";
  }
}

void trigonomatryInverseFunc(String invFunc) {
  double x = 0;
  String expTmp = "";
  expTmp = expression;

  if (invFunc == "CosInv") {
    x = double.parse(screen);
    screen = ((acos(x) * (180 / 3.14)).round()).toString();
    expression="";
    expression+="acos(";
    expression+=expTmp;
    expression+=")";
  } else if (invFunc == "SinInv") {
    x = double.parse(screen);
    screen = ((asin(x) * (180 / 3.14)).round()).toString();
    expression="";
    expression+="asin(";
    expression+=expTmp;
    expression+=")";
  } else if (invFunc == "TanInv") {
    x = double.parse(screen);
    screen = ((atan(x) * (180 / 3.14)).round()).toString();
    expression="";
    expression+="atan(";
    expression+=expTmp;
    expression+=")";
  } else if (invFunc == "CotInv") {
    x = double.parse(screen);
    screen = ((atan(1 / x) * (180 / 3.14)).round()).toString();
    expression="";
    expression+="acot(";
    expression+=expTmp;
    expression+=")";
  }
}

void handleDecimals(double x) {
  int? decimals = 0;
  List<String> substr = x.toString().split('.');

  if (substr.length > 0) {
    decimals = int.tryParse(substr[0]);

    screen = decimals.toString();

    if (substr.length > 1) {
      decimals = int.tryParse(substr[1]);

      if (decimals != null && decimals > 0) {
        screen += ".";
        screen += decimals.toString();
      }
    }
  }
}

void XrestoY() {
  if (screen.length > 0 && isOperator()) {
    Expression exp = Expression(screen);
    screen = exp.eval().toString();
    screen += '^';
    expression+="^";

  } else {
    screen = screen.substring(0, screen.length - 1);
    screen += '^';
    expression+="^";
  }
}

void nthRoot() {
  if (screen.length > 0 && isOperator()) {
    // Expression exp = Expression(screen);
    // screen = exp.eval().toString();

    if (isfirstTime) {
      b = int.parse(screen);
      screen += '\u221A';
      isfirstTime = false;
    } else {
      isfirstTime = true;
      int index = screen.indexOf('\u221A');

      String str = screen.substring(index + 1);

      a = int.parse(str);

      Expression exp = Expression("${a} ^ ${1 / b}");

      screen = exp.eval().toString();

    }
  } else {
    screen = screen.substring(0, screen.length - 1);

    b = int.parse(screen);
    screen += '\u221A';
  }
}

void findFactorial(String num) {
  int n = int.tryParse(num) ?? 1;
  int factorial = 1;
  String expTmp = "";
  expTmp = expression;
  expression="";

  expression+="(";
  expression+=expTmp;
  expression+=")!";

  for (int i = 1; i <= n; i++) {
    factorial *= i;
  }

  screen = factorial.toString();
}

void fibonacci() {
  double n = double.parse(screen);
  int num = n.toInt();
  // print(num);
  String expTmp = "";
  expTmp = expression;
  expression="";
  int a = 0, b = 1;

  expression+="fib(${expTmp})";

  if (num == 1)
    screen = "0";
  else if (num == 2)
    screen = "1";
  else {
    num -= 2;

    for (int i = 0; i < num; i++) {
      int temp = b;
      b = a + b;
      a = temp;
    }

    screen = b.toString();
  }
}

