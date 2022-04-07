//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quizapp/answer.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _questionIndex = 0;
  List<Icon> _scoreTracker = [];
  bool answerSelect = false;
  bool endOfquiz = false;
  int _totalScore = 0;
  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerSelect = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        _correctAnswerSelect = true;
      }
      // score tracker on top
      _scoreTracker.add(answerScore
          ? Icon(
              Icons.check_circle,
              color: Colors.lightGreenAccent,
            )
          : Icon(
              Icons.clear,
              color: Colors.red,
            ));
      // when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfquiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      _correctAnswerSelect = false;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfquiz = false;
    });
  }

  bool _correctAnswerSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 19,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130,
              margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]["questions"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...(_questions[_questionIndex]["answers"]
                    as List<Map<String, Object>>)
                .map(
              (e) => Answer(
                  answerText: e["answerText"].toString(),
                  colorsText: answerSelect
                      ? e["score"] as bool
                          ? Colors.lightGreen
                          : Colors.red
                      : Colors.white,
                  answerTap: () {
                    if (answerSelect) {
                      return;
                    }

                    _questionAnswered(e["score"] as bool);
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                if (!answerSelect) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("cant skip the question")));
                  return;
                }
                _nextQuestion();
                answerSelect = false;
                if (_questionIndex >= _questions.length) {
                  _restartQuiz();
                }
              },
              child: Text(endOfquiz ? "restart quiz" : "next question"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55)),
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "${_totalScore.toString()}/${_questions.length}",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerSelect && !endOfquiz)
              Expanded(
                child: Container(
                  color: _correctAnswerSelect ? Colors.lightGreen : Colors.red,
                  // height: 80,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      _correctAnswerSelect ? "you got it" : "wrong",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            if (endOfquiz)
              Expanded(
                child: Container(
                  color: _totalScore > 3 ? Colors.white : Colors.grey,
                  // color: _correctAnswerSelect ? Colors.lightGreen : Colors.red,
                  // height: 80,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      _totalScore > 3 ? "good" : "not good",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  final _questions = const [
    {
      "questions": " swadique favorite food??",
      "answers": [
        {"answerText": "porotta", "score": false},
        {"answerText": "mandhi", "score": true},
        {"answerText": "biriyani", "score": false},
        {"answerText": "burger", "score": false}
      ],
    },
    {
      "questions": "what is my favorite colour",
      "answers": [
        {"answerText": "Blue", "score": true},
        {"answerText": "White", "score": false},
        {"answerText": "Yellow", "score": false},
        {"answerText": "Green", "score": false}
      ]
    },
    {
      "questions": "my usually walk",
      "answers": [
        {"answerText": "fairly fast with long steps", "score": false},
        {"answerText": "fairly fast with little steps", "score": true},
        {"answerText": "very slowly", "score": false},
        {"answerText": "less fast head down", "score": false}
      ]
    },
    {
      "questions": "what Is my favorite tv show",
      "answers": [
        {"answerText": "stranger things", "score": false},
        {"answerText": "lost", "score": false},
        {"answerText": "lucifer", "score": false},
        {"answerText": "attack on titan", "score": true}
      ]
    },
    {
      "questions": "How much sleep do i need",
      "answers": [
        {"answerText": "8 hours", "score": false},
        {"answerText": "9 hours", "score": false},
        {"answerText": "6 hours", "score": true},
        {"answerText": "7 hours", "score": false}
      ]
    }
  ];
}
