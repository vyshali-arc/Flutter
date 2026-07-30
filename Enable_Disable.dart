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

  // Enable/Disable variable
  bool isEnabled = true;

  void incrementCourse() {
    if (isEnabled) {
      setState(() {
        courseNumber++;
      });
    }
  }

  void decrementCourse() {
    if (isEnabled && courseNumber > 1) {
      setState(() {
        courseNumber--;
      });
    }
  }

  // Enable/Disable function
  void toggleButton(bool value) {
    setState(() {
      isEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Stateful Widget Example",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            // Enable Disable Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  "Enable Buttons",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Switch(
                  value: isEnabled,
                  onChanged: toggleButton,
                ),
              ],
            ),

            const SizedBox(height: 50),

            Center(
              child: Column(
                children: [

                  const Text(
                    "🎓",
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Course $courseNumber",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Click Me Button
                  ElevatedButton(
                    onPressed: isEnabled ? incrementCourse : null,
                    child: const Text("Click Me"),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      IconButton(
                        onPressed: isEnabled ? decrementCourse : null,
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
                        onPressed: isEnabled ? incrementCourse : null,
                        icon: const Icon(
                          Icons.add,
                          size: 35,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    isEnabled ? "Buttons Enabled" : "Buttons Disabled",
                    style: TextStyle(
                      fontSize: 18,
                      color: isEnabled ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
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
