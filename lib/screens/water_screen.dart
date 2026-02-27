import 'package:flutter/material.dart';
import '../data/fitness_repository.dart';
import '../models/water.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final TextEditingController _waterController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  List<WaterData> get waterList => FitnessRepository.getWaterList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Intake')),
      body: Column(
        children: [_buildInputSection(), const Divider(), _buildWaterList()],
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
            controller: _waterController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Water intake (liter)',
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
          ElevatedButton(
            onPressed: _addWater,
            child: const Text('Add water intake'),
          ),
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

  // ADD WATER
  void _addWater() {
    final amount = double.tryParse(_waterController.text);
    if (amount == null) return;

    final success = FitnessRepository.addWater(
      WaterData(date: _selectedDate, amount: amount),
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Water data for this date already exists'),
        ),
      );
      return;
    }

    setState(() {
      _waterController.clear();
    });
  }

  // WATER LIST
  Widget _buildWaterList() {
    if (waterList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No water data yet'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: waterList.length,
        itemBuilder: (context, index) {
          final item = waterList[index];
          return ListTile(
            title: Text('${item.amount} liter'),
            subtitle: Text(
              '${item.date.year}-${item.date.month}-${item.date.day} • '
              '${FitnessRepository.getWaterStatus(item.amount)}',
            ),
            onTap: () => _showEditDialog(item),
            onLongPress: () => _deleteWater(item.date),
          );
        },
      ),
    );
  }

  // EDIT
  void _showEditDialog(WaterData data) {
    final controller = TextEditingController(text: data.amount.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Water Intake'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Liter'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newAmount = double.tryParse(controller.text);
                if (newAmount == null) return;

                FitnessRepository.updateWater(data.date, newAmount);

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
  void _deleteWater(DateTime date) {
    FitnessRepository.deleteWater(date);
    setState(() {});
  }
}
