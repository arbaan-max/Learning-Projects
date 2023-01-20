import 'dart:convert';

class Student {
  final String name;
  final String roll;
  final int id;
  final String adderess;

  Student(this.name, this.roll, this.id, this.adderess);


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'roll': roll});
    result.addAll({'id': id});
    result.addAll({'adderess': adderess});
  
    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      map['name'] ?? '',
      map['roll'] ?? '',
      map['id']?.toInt() ?? 0,
      map['adderess'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));
}
