class Record {
  int? id;
  String name;
  int age;
  String address;
  String role; // Employee / Student

  Record({
    this.id,
    required this.name,
    required this.age,
    required this.address,
    required this.role,
  });

  // Convert object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
      'role': role,
    };
  }

  // Convert Map to object
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
