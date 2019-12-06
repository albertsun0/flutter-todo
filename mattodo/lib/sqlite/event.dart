import 'dart:convert';

//task = 1 instance 

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int id;
  String text;
  bool repeat;
  bool longterm;

  Task({
    this.id,
    this.text,
    this.repeat,
    this.longterm,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        text: json["_text"],
        repeat: json["_repeat"] == 1,
        longterm: json["_longterm"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "_text": text,
        "_repeat": repeat,
        "_longterm": longterm,
      };
}