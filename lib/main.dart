import 'package:crypto_app/src/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF4CDA63)),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Color(0xFF4CDA63).withOpacity(0.7),
          selectionHandleColor: Color(0xFF4CDA63),
        ),
      ),
      home: HomePage(),
    );
  }
}
