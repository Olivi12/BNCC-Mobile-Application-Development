import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/fitness_repository.dart';
import '../models/steps.dart';
import '../models/water.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatDate(DateTime date) {
    return DateFormat('EEE, d MMM yyyy').format(date);
  }

  // UNIQUE DATES
  List<DateTime> _getAllDates() {
    final steps = FitnessRepository.getStepsList();
    final water = FitnessRepository.getWaterList();

    final Set<DateTime> dates = {};

    for (var s in steps) {
      dates.add(DateTime(s.date.year, s.date.month, s.date.day));
    }
    for (var w in water) {
      dates.add(DateTime(w.date.year, w.date.month, w.date.day));
    }

    final list = dates.toList();
    list.sort((a, b) => b.compareTo(a)); // newest first
    return list;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Good':
        return Colors.green;
      case 'Average':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dates = _getAllDates();

    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Summary')),
      body: dates.isEmpty
          ? const Center(child: Text('No fitness data yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                return _buildDailyCard(dates[index]);
              },
            ),
    );
  }

  // DAILY SUMMARY CARD
  Widget _buildDailyCard(DateTime date) {
    final steps = FitnessRepository.getStepsByDate(date);
    final water = FitnessRepository.getWaterByDate(date);

    final String? stepsStatus = steps == null
        ? null
        : FitnessRepository.getStepsStatus(steps.steps);
    final String? waterStatus = water == null
        ? null
        : FitnessRepository.getWaterStatus(water.amount);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDate(date),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // STEPS
            Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  color: stepsStatus == null
                      ? Colors.grey
                      : _statusColor(stepsStatus),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: steps == null
                      ? const Text(
                          'Steps: No data',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          'Steps: ${steps.steps} ($stepsStatus)',
                          style: TextStyle(
                            color: _statusColor(stepsStatus!),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // WATER
            Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: waterStatus == null
                      ? Colors.grey
                      : _statusColor(waterStatus),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: water == null
                      ? const Text(
                          'Water: No data',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          'Water: ${water.amount} L ($waterStatus)',
                          style: TextStyle(
                            color: _statusColor(waterStatus!),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
