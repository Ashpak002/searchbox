import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_page.dart';
import 'search_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white70,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: SearchPage(),
    );
  }
}
