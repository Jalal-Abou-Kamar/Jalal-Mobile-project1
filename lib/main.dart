import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FitnessTrackerPage(),
    );
  }
}

class FitnessTrackerPage extends StatefulWidget {
  const FitnessTrackerPage({super.key});

  @override
  _FitnessTrackerPageState createState() => _FitnessTrackerPageState();
}

class _FitnessTrackerPageState extends State<FitnessTrackerPage> {
  final TextEditingController _stepsController = TextEditingController();
  double? _caloriesBurned;
  double? _heartRate;

  void _calculateMetrics() {
    final steps = int.tryParse(_stepsController.text);
    if (steps != null) {
      setState(() {
        _caloriesBurned = steps * 0.04; // Example formula: 0.04 kcal per step
        _heartRate = 70 + (steps / 1000); // Example formula: increases slightly with steps
      });
    } else {
      setState(() {
        _caloriesBurned = null;
        _heartRate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _stepsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Steps Taken',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateMetrics,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (_caloriesBurned != null) ...[
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        size: 50,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Calories Burned',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_caloriesBurned!.toStringAsFixed(2)} kcal',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (_heartRate != null) ...[
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 50,
                        color: Colors.pink,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Estimated Heart Rate',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_heartRate!.toStringAsFixed(2)} bpm',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
