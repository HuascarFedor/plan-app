class Task {
  final int? id;
  String description;
  bool complete;
  final int planId;

  Task({
    this.id,
    this.description = '',
    this.complete = false,
    required this.planId,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        description: map['descroption'],
        complete: map['complete'] == 1,
        planId: map['planId']);
  }

  Map<String, dynamic> toMap() {
    return {
      if(id != null) 'id': id,
      'description': description,
      'complete': complete ? 1 : 0,
      'planId': planId
    };
  }
}
