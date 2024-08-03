import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/workout_data.dart';

import 'workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }


  final newWorkoutNameController = TextEditingController();
  void createNewWorkout() {
    showDialog(context: context,
    builder: (context) => AlertDialog(
      title: const Text("Create a new workout"),
      content: TextField(
        controller: newWorkoutNameController,
      ),
      actions: [
        MaterialButton(
          onPressed: save,
        child: const Text("Save"),
        ),
        MaterialButton(
          onPressed: cancel,
          child: const Text("Cancel"),
          )
      ],
    ),
    );
  }

void goToWorkoutPage(String workoutName) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => WorkoutPage(
    workoutName: workoutName,
  ),
  ));
}

void save() {
  String newWorkoutName = newWorkoutNameController.text;
  Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
  Navigator.pop(context);
}
 
void cancel() {
  Navigator.pop(context);
  clear();
}
void clear() {
  newWorkoutNameController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
      appBar: AppBar(
        title: const Text("Workout Tracker"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewWorkout,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: value.getWorkoutList().length,
        itemBuilder: (context, index) => ListTile(
        title: Text(value.getWorkoutList()[index].name),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
          ),
      ),
    ),
    ),
  );
  }
}