import 'package:flutter/material.dart';
import 'package:news_app/HomePage.dart';
import 'package:news_app/NewsSearchPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 78, 9, 198)),
        // useMaterial3: true,
      ),
      home: HomePage(),
      //  NewsSearchPage(query: ''),
    );
  }
}
