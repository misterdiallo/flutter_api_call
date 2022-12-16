import 'package:flutter/material.dart';
import 'package:flutter_api_call/screen/home.dart';

void main() {
  runApp(const MyApp());
}

// data are generate from api: https://jsonplaceholder.typicode.com/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter API Call',
      theme:
          ThemeData(primarySwatch: Colors.orange, brightness: Brightness.light),
      themeMode: ThemeMode.dark,
      darkTheme:
          ThemeData(primarySwatch: Colors.orange, brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}
