import 'package:flutter/material.dart';
import 'dart:math';

class VolumePage extends StatefulWidget {
  const VolumePage({super.key});

  @override
  State<VolumePage> createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  String selectedShape = "Balok";

  TextEditingController panjang = TextEditingController();
  TextEditingController lebar = TextEditingController();
  TextEditingController tinggi = TextEditingController();

  TextEditingController luasAlas = TextEditingController();

  TextEditingController jariJari = TextEditingController();

  double hasil = 0;

  void hitungVolume() {
    setState(() {
      if (selectedShape == "Balok") {
        if (panjang.text.isEmpty || lebar.text.isEmpty || tinggi.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Panjang, lebar, dan tinggi harus diisi"),
            ),
          );

          return;
        }

        double p = double.parse(panjang.text);
        double l = double.parse(lebar.text);
        double t = double.parse(tinggi.text);

        hasil = p * l * t;
      } else if (selectedShape == "Piramid") {
        if (luasAlas.text.isEmpty || tinggi.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Luas alas dan tinggi harus diisi")),
          );

          return;
        }

        double la = double.parse(luasAlas.text);
        double t = double.parse(tinggi.text);

        hasil = (1 / 3) * la * t;
      } else if (selectedShape == "Tabung") {
        if (jariJari.text.isEmpty || tinggi.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Jari-jari dan tinggi harus diisi")),
          );

          return;
        }

        double r = double.parse(jariJari.text);
        double t = double.parse(tinggi.text);

        hasil = pi * r * r * t;
      }
    });
  }

  Widget buildInputField() {
    if (selectedShape == "Balok") {
      return Column(
        children: [
          TextField(
            controller: panjang,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Masukkan panjang",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: lebar,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Masukkan lebar",
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
    } else if (selectedShape == "Piramid") {
      return Column(
        children: [
          TextField(
            controller: luasAlas,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Masukkan luas alas",
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
      return Column(
        children: [
          TextField(
            controller: jariJari,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Masukkan jari-jari",
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Volume Calculator")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Bangun Ruang",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                initialValue: selectedShape,

                decoration: const InputDecoration(border: OutlineInputBorder()),

                items: const [
                  DropdownMenuItem(value: "Balok", child: Text("Balok")),

                  DropdownMenuItem(value: "Piramid", child: Text("Piramid")),

                  DropdownMenuItem(value: "Tabung", child: Text("Tabung")),
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

                  onPressed: hitungVolume,

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
