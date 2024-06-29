import 'dart:convert';

List<todomodel> postModelFromjson(String str) =>
    List<todomodel>.from(json.decode(str).map((x) => todomodel.fromjson(x)));

String postModelToJson(List<todomodel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.tojson())));

class todomodel {
  todomodel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
  });

  int id;
  String title;
  String date;
  String description;

  factory todomodel.fromjson(Map<String, dynamic> json) => todomodel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      description: json['description']);

  Map<String, dynamic> tojson() => {
        "id": id,
        "title": title,
        "date": date,
        "description": description,
      };
}
