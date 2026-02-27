import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/steps_screen.dart';
import 'screens/water_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 230, 223, 240),
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const StepsScreen(),
    const WaterScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Steps',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Water'),
        ],
      ),
    );
  }
}
