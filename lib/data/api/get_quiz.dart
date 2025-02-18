import 'package:http/http.dart' as http;
import 'dart:convert';

class Quiz {
  final String? id;
  final String?title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final DateTime? createdAt;

  Quiz({
     this.id,
     this.title,
     this.duration,
     this.subject,
     this.numberOfQuestions,
     this.active,
     this.createdAt,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      subject: json['subject'],
      numberOfQuestions: json['numberOfQuestions'],
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

Future<Quiz> fetchQuiz() async {
  final response =
      await http.get(Uri.parse('https://exam.elevateegy.com/api/v1/exams'));

  if (response.statusCode == 200) {
    return Quiz.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load quiz');
  }
}
