import 'package:flutter/material.dart';
import 'features/auth/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        // textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 17,
          ),
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Color(0xFF242424),
            fontWeight: FontWeight.w400,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
            color: Color(0xFF242424),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.redAccent,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
