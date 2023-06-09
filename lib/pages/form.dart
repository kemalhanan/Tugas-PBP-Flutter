import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:study_tracker/pages/assignment.dart';
import 'package:study_tracker/pages/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaTugas = '';
  String _namaMataKuliah = '';
  int _progress = 0;
  DateTime _tanggalTugas = DateTime.now();
  String _deskripsiTugas = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      drawer: const DrawerMenu(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Tugas Kelompok",
                      labelText: "Nama Tugas",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.edit_note),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _namaTugas = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _namaTugas = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tugas tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Pemrograman Berbasis Platform",
                      labelText: "Nama Mata Kuliah",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.edit_note),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _namaMataKuliah = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _namaMataKuliah = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Mata Kuliah tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: "Contoh: 40",
                      labelText: "Progress",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.edit_note),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat jumlah diketik
                    onChanged: (String? value) {
                      setState(() {
                        _progress = int.parse(value!);
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _progress = int.parse(value!);
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah transaksi tidak boleh kosong!';
                      } else if (int.parse(value) > 100) {
                        return 'Progress tidak boleh lebih dari 100!';
                      } else if (int.parse(value) < 0) {
                        return 'Progress tidak boleh kurang dari 0!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Sebelum ujian akhir semester!",
                      labelText: "Deskripsi Tugas",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.notes),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _deskripsiTugas = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _deskripsiTugas = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tugas tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Tambah",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        'https://tugas-pbp.domcloud.io/tracker/create-flutter/',
                        convert.jsonEncode(
                          <String, String>{
                            'nama_tugas': _namaTugas,
                            'nama_mata_kuliah': _namaMataKuliah,
                            'progress': _progress.toString(),
                            'tanggal_tugas': _tanggalTugas.toString(),
                            'deskripsi_tugas': _deskripsiTugas,
                          },
                        ),
                      );
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tugas berhasil ditambahkan!'),
                          ),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AssignmentPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tugas gagal ditambahkan!'),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
