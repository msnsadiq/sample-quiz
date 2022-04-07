import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizapp/ScreenHome.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "quiz app",
      theme: ThemeData(primarySwatch: Colors.brown),
      home: ScreenHome(),
    );
  }
}
