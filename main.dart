import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout_tracker/data/workout_data.dart';
import 'package:workout_tracker/pages/home_page.dart';
import 'package:provider/provider.dart'; 

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("workout_database");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      )
      );
  }
}
