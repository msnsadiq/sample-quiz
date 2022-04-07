import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  //const Answer({Key? key}) : super(key: key);
  final String answerText;
  final Color colorsText;
  final Function() answerTap;
  Answer(
      {required this.answerText,
      required this.colorsText,
      required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        // color: Colors.blue,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: null,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorsText,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
