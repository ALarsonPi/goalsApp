import 'Goal.dart';

class Priority {
  String imageUrl;
  String name;
  List<Goal> goals = List.empty(growable: true);
  Priority(this.name, this.imageUrl, this.goals);

  setName(String newName) {
    name = newName;
  }

  setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  factory Priority.fromJson(Map<String, dynamic> json) {
    return Priority(
      json['name'],
      json['imageUrl'],
      json['goals'],
    );
  }

  Map<String, dynamic> toJson() => _priorityToJson(this);

  Map<String, dynamic> _priorityToJson(Priority instance) => <String, dynamic>{
        'imageUrl': instance.imageUrl,
        'name': instance.name,
        'goals': instance.goals,
      };

  @override
  String toString() {
    String toPrint = "";
    toPrint += "Priority\nName: $name\n$imageUrl\n";
    for (int i = 0; i < goals.length; i++) {
      toPrint += goals[i].toString();
    }
    return toPrint;
  }
}
