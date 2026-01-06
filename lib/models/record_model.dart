class Record {
  int? id;
  String name;
  int age;
  String address;
  String role;

  Record({
    this.id,
    required this.name,
    required this.age,
    required this.address,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
      'role': role,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      address: map['address'],
      role: map['role'],
    );
  }
}
