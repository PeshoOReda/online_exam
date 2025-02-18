import 'package:flutter/material.dart';
import 'package:online_exam/presentation/home/card_level.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
          title: Text('Languages')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'English',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                CardExam(),
                CardExam(),
                CardExam(),
                SizedBox(height: 16),
                Text(
                  'Spanish',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                CardExam(),
                CardExam(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

