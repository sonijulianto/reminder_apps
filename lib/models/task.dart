class Task {
  late int? id;
  late String title;
  late String description;
  late String date;
  late String time;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    };
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    date = map['date'];
    time = map['time'];
  }
}
