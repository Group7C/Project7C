import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/login",
    routes:
    {
      "/login": (context) => const LoginScreen()
    },
  )
  );
}