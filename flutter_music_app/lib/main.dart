import 'package:flutter/material.dart';
import 'package:flutter_music_app/product/theme/mytheme.dart';
import 'package:flutter_music_app/view/home.dart';

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
        scaffoldBackgroundColor: MyTheme.backgroundColor,
      ),
      home: Home(),
    );
  }
}
