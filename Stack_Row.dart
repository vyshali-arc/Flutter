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
home: const HomePage(),
);
}
}

class HomePage extends StatelessWidget {
const HomePage({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Layouts"), centerTitle: false),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
children: [
// Heading
const Text(
"Row Widget",
style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
),

const SizedBox(height: 10),

// Row with 3 Icons
Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: const [
Icon(Icons.home, size: 50, color: Colors.black),
Icon(Icons.favorite, size: 50, color: Colors.black),
Icon(Icons.settings, size: 50, color: Colors.black),
],
),

const SizedBox(height: 60),

// Heading
const Text(
"Stack Widget",
style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
),

const SizedBox(height: 20),

// Stack
Stack(
alignment: Alignment.center,
children: [
Container(width: 200, height: 200, color: Colors.black),
Container(width: 120, height: 120, color: Colors.blue),
],
),
],
),
),
);
}
}
