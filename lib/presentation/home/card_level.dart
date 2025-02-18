import 'package:flutter/material.dart';
import 'package:online_exam/data/api/get_quiz.dart';

class CardExam extends StatelessWidget {
  const CardExam({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/Profit.png',
              width: 100,
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${Quiz().title}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${Quiz().numberOfQuestions.toString()} Questions',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'From: 1.00 To: 6.00',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Text(
              Quiz().duration.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
