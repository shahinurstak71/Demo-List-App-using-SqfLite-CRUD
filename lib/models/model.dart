class Student {
  int id;
  String name;
  String subject;
  Student({this.id, this.name, this.subject});
  Map<String, dynamic> toMap() {
    return {'name': name, 'subject': subject};
  }
}
