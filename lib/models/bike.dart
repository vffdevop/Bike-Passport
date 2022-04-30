class Bike {
  String id;
  String name;
  int type = 0;

  Bike({required this.id, required this.name, required this.type});

  factory Bike.fromMap(Map<String, dynamic> obj) {
    return Bike(id: obj['id'], name: obj['name'], type: obj['type']);
  }
}
