import 'Goal.dart';
import 'package:collection/collection.dart';

class Priority {
  String imageUrl;
  String name;
  List<Goal> goals = List.empty(growable: true);
  int priorityIndex = -1;
  Priority(this.name, this.imageUrl, this.goals, this.priorityIndex);

  setName(String newName) {
    name = newName;
  }

  setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  factory Priority.fromJson(Map<String, dynamic> json) {
    List<Goal> priorityGoals = List.empty(growable: true);

    if (json['goals'] != null) {
      for (var goalJSON in json['goals']) {
        Goal newGoal = Goal.fromJson(goalJSON);
        priorityGoals.add(newGoal);
      }
    }

    return Priority(
      json['name'] ?? "",
      json['imageUrl'] ?? "",
      priorityGoals,
      json['priorityIndex'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() => _priorityToJson(this);

  Map<String, dynamic> _priorityToJson(Priority instance) => <String, dynamic>{
        'imageUrl': instance.imageUrl,
        'name': instance.name,
        'goals': instance.goals,
        'priorityIndex': instance.priorityIndex,
      };

  equals(Priority toCompareTo) {
    Function deepEq = const DeepCollectionEquality().equals;
    bool goalsAreEqual = deepEq(goals, toCompareTo.goals);
    return (toCompareTo is Priority &&
        toCompareTo.name == name &&
        toCompareTo.imageUrl == toCompareTo.imageUrl &&
        toCompareTo.priorityIndex == priorityIndex &&
        goalsAreEqual);
  }

  List getGoalsAsListofJSON() {
    List listOfJSONs = List.empty(growable: true);
    for (Goal goal in goals) {
      listOfJSONs.add(goal.toJson());
    }
    return listOfJSONs;
  }

  @override
  String toString() {
    String toPrint = "";
    toPrint +=
        "Priority\nName: $name\n$imageUrl\nPriority index: $priorityIndex\n";
    for (int i = 0; i < goals.length; i++) {
      toPrint += goals[i].toString();
    }
    return toPrint;
  }
}