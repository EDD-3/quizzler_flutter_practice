import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<Question> questions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true)
  ];
  int questionNumber = 0;
  static const Color trueColor = Colors.green;
  static const Color falseColor = Colors.red;
  static const Color defaultTextColor = Colors.white;

  void addScore({IconData? icon, Color? color}) {
    setState(() {
      questionNumber++;
      scoreKeeper.add(Icon(icon, color: color));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionNumber].text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: defaultTextColor,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: trueColor,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: defaultTextColor,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswer = questions[questionNumber].answer;

                if (correctAnswer == true) {
                  addScore(icon: Icons.check, color: trueColor);
                } else {
                  addScore(icon: Icons.close, color: falseColor);
                }

                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: falseColor),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: defaultTextColor,
                ),
              ),
              onPressed: () {
                bool correctAnswer = questions[questionNumber].answer;

                if (correctAnswer == false) {
                  addScore(icon: Icons.check, color: trueColor);
                } else {
                  addScore(icon: Icons.close, color: falseColor);
                }
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
