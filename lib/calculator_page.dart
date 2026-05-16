import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String selectedShape = "Persegi";

  TextEditingController sisi = TextEditingController();
  TextEditingController alas = TextEditingController();
  TextEditingController tinggi = TextEditingController();
  TextEditingController jariJari = TextEditingController();

  double hasil = 0;

  void hitungLuas() {
    setState(() {
      if (selectedShape == "Persegi") {
        if (sisi.text.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Sisi harus diisi")));

          return;
        }

        double s = double.parse(sisi.text);

        hasil = s * s;
      } else if (selectedShape == "Segitiga") {
        if (alas.text.isEmpty || tinggi.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Alas dan tinggi harus diisi")),
          );

          return;
        }

        double a = double.parse(alas.text);
        double t = double.parse(tinggi.text);

        hasil = 0.5 * a * t;
      } else if (selectedShape == "Lingkaran") {
        if (jariJari.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Jari-jari harus diisi")),
          );

          return;
        }

        double r = double.parse(jariJari.text);

        hasil = pi * r * r;
      }
    });
  }

  Widget buildInputField() {
    if (selectedShape == "Persegi") {
      return TextField(
        controller: sisi,
        keyboardType: TextInputType.number,

        decoration: const InputDecoration(
          labelText: "Masukkan sisi",
          border: OutlineInputBorder(),
        ),
      );
    } else if (selectedShape == "Segitiga") {
      return Column(
        children: [
          TextField(
            controller: alas,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Masukkan alas",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: tinggi,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Masukkan tinggi",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      );
    } else {
      return TextField(
        controller: jariJari,
        keyboardType: TextInputType.number,

        decoration: const InputDecoration(
          labelText: "Masukkan jari-jari",
          border: OutlineInputBorder(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Area Calculator")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Bangun Datar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                initialValue: selectedShape,

                decoration: const InputDecoration(border: OutlineInputBorder()),

                items: const [
                  DropdownMenuItem(value: "Persegi", child: Text("Persegi")),

                  DropdownMenuItem(value: "Segitiga", child: Text("Segitiga")),

                  DropdownMenuItem(
                    value: "Lingkaran",
                    child: Text("Lingkaran"),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedShape = value!;
                    hasil = 0;
                  });
                },
              ),

              const SizedBox(height: 20),

              buildInputField(),

              const SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),

                  onPressed: hitungLuas,

                  child: const Text("Hitung", style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child: Text(
                  "Hasil: ${hasil.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
