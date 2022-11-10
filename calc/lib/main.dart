import 'package:flutter/material.dart';
import 'package:calc/arithmetic.dart';
import 'package:calc/scientific.dart';
import 'package:calc/matrix.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Arithmetic(),
    title: 'Scientific Calculator',
    routes: {
      'home' : (context) => Arithmetic(),
      'scientific' : (context) => Scientific(),
      'matrix' : (context) => Matrix(),
    },
  ));
}
