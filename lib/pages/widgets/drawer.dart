import 'package:study_tracker/pages/assignment.dart';
import 'package:study_tracker/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:study_tracker/pages/form.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Menu'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Form'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyFormPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Assignment'),
            onTap: () {
              // Route menu ke halaman assignment
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AssignmentPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
