import 'dart:convert';
import 'package:http/http.dart' as http;

class Subject {
  final String? id;
  final String? name;
  final String? icon;
  final DateTime? createdAt;

  Subject({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

Future<Subject?> fetchSubject() async {
  final response =
      await http.get(Uri.parse('https://exam.elevateegy.com/api/v1/subjects'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Subject.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}
