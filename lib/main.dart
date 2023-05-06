import 'package:flutter/material.dart';
import 'quizz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizzBrain quizzBrain = QuizzBrain();
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
  static const Color trueColor = Colors.green;
  static const Color falseColor = Colors.red;
  static const Color defaultTextColor = Colors.white;

  void checkAnswer({bool? userPickedAnswer}) {
    if (quizzBrain.isFinished()) {
      final int finalScore = quizzBrain.getFinalScore();
      print('The quizz is finished, time to start over!');
      setState(() {
        Alert(
          context: context,
          title: "Hello!",
          desc: "You have reached the end of the quizz. "
              "You got $finalScore out of 12 correct answers",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "Start over",
                style: TextStyle(
                  color: defaultTextColor,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ).show();
        quizzBrain.reset();
      });
    } else {
      setState(() {
        bool correctAnswer = quizzBrain.getCorrectAnswer();
        quizzBrain.nextQuestion();

        if (userPickedAnswer == correctAnswer) {
          quizzBrain.addScore(Icons.check, trueColor);
        } else {
          quizzBrain.addScore(Icons.close, falseColor);
        }
      });
    }
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
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                checkAnswer(userPickedAnswer: true);
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
                checkAnswer(userPickedAnswer: false);
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: quizzBrain.getScore(),
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
