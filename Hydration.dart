import 'package:flutter/material.dart';

void main() {
  runApp(const SmartWaterIntakeTracker());
}

class SmartWaterIntakeTracker extends StatelessWidget {
  const SmartWaterIntakeTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Water Intake Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WaterTrackerPage(),
    );
  }
}

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final TextEditingController waterController = TextEditingController();

  // Daily hydration goal
  final double dailyGoal = 2000;

  // Stores all water intake entries
  final List<double> waterEntries = [];

  double get totalConsumed {
    return waterEntries.fold(0, (sum, amount) => sum + amount);
  }

  double get remainingWater {
    final remaining = dailyGoal - totalConsumed;
    return remaining > 0 ? remaining : 0;
  }

  double get completionPercentage {
    double percentage = (totalConsumed / dailyGoal) * 100;

    if (percentage > 100) {
      return 100;
    }

    return percentage;
  }

  // Add water intake
  void addWater() {
    final String input = waterController.text.trim();
    final double? amount = double.tryParse(input);

    // Input validation
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid water amount greater than 0 mL.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      waterEntries.add(amount);
      waterController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${amount.toStringAsFixed(0)} mL added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Reset water intake with confirmation
  void confirmReset() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Reset Water Intake?'),
          content: const Text(
            'Are you sure you want to reset today\'s water intake?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  waterEntries.clear();
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Today\'s water intake has been reset.'),
                  ),
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    waterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Water Intake Tracker'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Daily Goal Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 60,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Daily Hydration Goal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${dailyGoal.toStringAsFixed(0)} mL',
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Progress Indicator
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Today\'s Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: totalConsumed / dailyGoal > 1
                          ? 1
                          : totalConsumed / dailyGoal,
                      minHeight: 15,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${completionPercentage.toStringAsFixed(0)}% Completed',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'Consumed',
                    '${totalConsumed.toStringAsFixed(0)} mL',
                    Icons.local_drink,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInfoCard(
                    'Remaining',
                    '${remainingWater.toStringAsFixed(0)} mL',
                    Icons.hourglass_bottom,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'Entries',
                    '${waterEntries.length}',
                    Icons.format_list_numbered,
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInfoCard(
                    'Completion',
                    '${completionPercentage.toStringAsFixed(0)}%',
                    Icons.percent,
                    Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Water Input
            TextField(
              controller: waterController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Enter water amount',
                hintText: 'Example: 500',
                suffixText: 'mL',
                prefixIcon: const Icon(Icons.water_drop),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Add Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: addWater,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Water',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Reset Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: confirmReset,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Reset Today\'s Intake',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Entry History
            if (waterEntries.isNotEmpty)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today\'s Entries',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: waterEntries.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: const Icon(
                                Icons.water_drop,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text(
                              '${waterEntries[index].toStringAsFixed(0)} mL',
                            ),
                            subtitle: Text(
                              'Entry ${index + 1}',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Goal completed message
            if (totalConsumed >= dailyGoal)
              const Card(
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Congratulations! You have reached your daily hydration goal!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Reusable information card
  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 8,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
