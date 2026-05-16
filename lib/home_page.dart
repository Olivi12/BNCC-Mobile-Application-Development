import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'counter_page.dart';
import 'calculator_page.dart';
import 'volume_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [CounterPage(), CalculatorPage(), VolumePage()];

  void logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 88, 255),

        title: Text(
          FirebaseAuth.instance.currentUser?.displayName ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),

            onSelected: (value) {
              if (value == "logout") {
                logout();
              }
            },

            itemBuilder: (context) => [
              const PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Counter"),

          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Area Calculator",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar),
            label: "Volume Calculator",
          ),
        ],
      ),
    );
  }
}
