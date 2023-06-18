import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:study_tracker/model/assignment.dart';
import 'package:study_tracker/pages/widgets/drawer.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key}) : super(key: key);

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  Future<List<Assignment>> fetchAssignments() async {
    var url = Uri.parse('https://tugas-pbp.domcloud.io/tracker/json/');
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    var data = convert.jsonDecode(response.body);

    List<Assignment> assignments = [];
    for (var d in data) {
      if (d != null) {
        assignments.add(Assignment.fromJson(d));
      }
    }
    return assignments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment"),
      ),
      drawer: const DrawerMenu(),
      body: FutureBuilder(
          future: fetchAssignments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text("No Data"),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          // Route menu ke halaman form
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedInfoScreen(
                                    assignment: snapshot.data![index])),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: snapshot.data![index].fields.subject ==
                                          "Pemrograman Berbasis Platform"
                                      ? Colors.blue
                                      : Colors.red,
                                  blurRadius: 2.0,
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].fields.name}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${snapshot.data![index].fields.subject}",
                                  ),
                                  Text(
                                    "${snapshot.data![index].fields.date.day}/${snapshot.data![index].fields.date.month}/${snapshot.data![index].fields.date.year}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )));
              }
            }
          }),
    );
  }
}

class DetailedInfoScreen extends StatelessWidget {
  final Assignment assignment;

  DetailedInfoScreen({required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment'),
      ),
      drawer: DrawerMenu(), // Add your drawer widget
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Assignment Name: ${assignment.fields.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Subject: ${assignment.fields.subject}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Progress: ${assignment.fields.progress}%',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Date: ${assignment.fields.date.day}/${assignment.fields.date.month}/${assignment.fields.date.year}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description: ${assignment.fields.description}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Add a text button to go back to the previous screen
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AssignmentPage()));
              },
              child: Text('Kembali', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
