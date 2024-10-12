import 'package:firebase_core/firebase_core.dart';
import 'package:firebasecurd/crudScreen.dart';
import 'package:firebasecurd/firebase_options.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Provide the correct options
  );
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Crudscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
