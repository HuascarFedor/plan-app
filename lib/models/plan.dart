class Plan {
  final int? id;
  final String name;

  Plan({this.id, this.name = ''});

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if(id != null) 
        'id': id,
      'name': name,
    };
  }
}
