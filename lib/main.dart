 import 'package:flutter/material.dart';
import 'package:to_do/add.dart';
import 'package:to_do/home.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/' : (context) => const Home(),
    '/second' : (context) => const Add(),
  },
));



