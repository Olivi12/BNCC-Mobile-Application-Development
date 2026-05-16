import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$number",
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  setState(() {
                    number--;
                  });
                },

                child: const Text("-", style: TextStyle(fontSize: 30)),
              ),

              const SizedBox(width: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  setState(() {
                    number++;
                  });
                },

                child: const Text("+", style: TextStyle(fontSize: 30)),
              ),
            ],
          ),

          const SizedBox(height: 50),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),

            onPressed: () {
              setState(() {
                number = 0;
              });
            },

            child: const Text("Reset", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
