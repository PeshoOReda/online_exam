import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Exam>> fetchExams() async {
  final response = await http.get(Uri.parse(
      'https://exam.elevateegy.com/api/v1/exams?subject=670037f6728c92b7fdf434fc'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)["exams"];
    return jsonResponse.map((exam) => Exam.fromJson(exam)).toList();
  } else {
    throw Exception('Failed to load exams');
  }
}

class Exam {
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final DateTime? createdAt;

  Exam({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
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
