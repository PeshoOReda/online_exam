import 'package:flutter/material.dart';
import 'package:online_exam/presentation/home/explore.dart';
import 'package:online_exam/presentation/home/home_screen.dart';

import 'presentation/home/level_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OnlineExam',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: HomeScreen(),
        routes: {
          '/languages': (context) => LevelScreen(),
          '/search_subjects': (context) => ExploreScreen()
        });
  }
}
