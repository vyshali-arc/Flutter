import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StatefulExample(),
    );
  }
}

class StatefulExample extends StatefulWidget {
  const StatefulExample({super.key});

  @override
  State<StatefulExample> createState() => _StatefulExampleState();
}

class _StatefulExampleState extends State<StatefulExample> {

  int courseNumber = 1;

  void incrementCourse() {
    setState(() {
      courseNumber++;
    });
  }

  void decrementCourse() {
    if (courseNumber > 1) {
      setState(() {
        courseNumber--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Heading at top-left corner
            const Text(
              "Stateful Widget Example",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 80),

            // Center content
            Center(
              child: Column(
                children: [

                  // Graduation emoji
                  const Text(
                    "🎓",
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Course display
                  Text(
                    "Course $courseNumber",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Button increments number
                  ElevatedButton(
                    onPressed: incrementCourse,
                    child: const Text("Click Me"),
                  ),

                  const SizedBox(height: 20),

                  // Decrement and Increment controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      IconButton(
                        onPressed: decrementCourse,
                        icon: const Icon(
                          Icons.remove,
                          size: 35,
                        ),
                      ),

                      Text(
                        "$courseNumber",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: incrementCourse,
                        icon: const Icon(
                          Icons.add,
                          size: 35,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
