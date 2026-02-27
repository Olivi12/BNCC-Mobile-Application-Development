import 'package:flutter/material.dart';
import '../data/fitness_repository.dart';
import '../models/steps.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  final TextEditingController _stepsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  List<StepsData> get stepsList => FitnessRepository.getStepsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Steps Tracker')),
      body: Column(
        children: [_buildInputSection(), const Divider(), _buildStepsList()],
      ),
    );
  }

  // INPUT SECTION
  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _stepsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Steps',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
              ),
              const Spacer(),
              TextButton(onPressed: _pickDate, child: const Text('Pick Date')),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _addSteps, child: const Text('Add steps')),
        ],
      ),
    );
  }

  // DATE PICKER
  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // CREATE
  void _addSteps() {
    final steps = int.tryParse(_stepsController.text);
    if (steps == null) return;

    final success = FitnessRepository.addSteps(
      StepsData(date: _selectedDate, steps: steps),
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Steps data for this date already exists'),
        ),
      );
      return;
    }

    setState(() {
      _stepsController.clear();
    });
  }

  // READ
  Widget _buildStepsList() {
    if (stepsList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No steps data yet'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: stepsList.length,
        itemBuilder: (context, index) {
          final item = stepsList[index];
          return ListTile(
            title: Text('${item.steps} steps'),
            subtitle: Text(
              '${item.date.year}-${item.date.month}-${item.date.day} • '
              '${FitnessRepository.getStepsStatus(item.steps)}',
            ),
            onTap: () => _showEditDialog(item),
            onLongPress: () => _deleteSteps(item.date),
          );
        },
      ),
    );
  }

  // UPDATE
  void _showEditDialog(StepsData data) {
    final controller = TextEditingController(text: data.steps.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Steps'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Steps'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newSteps = int.tryParse(controller.text);
                if (newSteps == null) return;

                FitnessRepository.updateSteps(data.date, newSteps);
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // DELETE
  void _deleteSteps(DateTime date) {
    FitnessRepository.deleteSteps(date);
    setState(() {});
  }
}
