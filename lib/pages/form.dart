import 'package:study_tracker/pages/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      drawer: const DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello World!'),
          ],
        ),
      ),
    );
  }
}
