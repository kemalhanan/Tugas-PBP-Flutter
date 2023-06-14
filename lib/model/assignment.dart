// To parse this JSON data, do
//
//     final assignment = assignmentFromJson(jsonString);

import 'dart:convert';

List<Assignment> assignmentFromJson(String str) =>
    List<Assignment>.from(json.decode(str).map((x) => Assignment.fromJson(x)));

String assignmentToJson(List<Assignment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Assignment {
  String model;
  int pk;
  Fields fields;

  Assignment({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String name;
  String subject;
  int progress;
  DateTime date;
  String description;

  Fields({
    required this.name,
    required this.subject,
    required this.progress,
    required this.date,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        subject: json["subject"],
        progress: json["progress"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subject": subject,
        "progress": progress,
        "date": date.toIso8601String(),
        "description": description,
      };
}
