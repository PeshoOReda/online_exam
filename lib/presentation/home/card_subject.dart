
import 'package:flutter/material.dart';
import 'package:online_exam/data/api/get_subject.dart';

class CardSubject extends StatelessWidget {
  const CardSubject({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Subject?>(
        future: fetchSubject(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final subject = snapshot.data;
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  subject != null
                      ? Image.network(subject.icon ?? '')
                      : CircularProgressIndicator(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(subject != null ? (subject.name ?? 'Loading...') : 'Loading...',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))
                ]));
          }
        });
  }
}
