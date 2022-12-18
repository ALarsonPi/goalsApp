class Goal {
  String name;
  bool isComplete;
  List<Goal> subGoals = List.empty(growable: true);

  Goal(this.name, this.isComplete, {subgoals}) {
    if (subgoals != null) {
      subGoals = subgoals;
    }
  }

  setName(String newName) {
    name = newName;
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    List<Goal> subGoalsList = List.empty(growable: true);
    for (var goalJSON in json['subgoals']) {
      Goal newGoal = Goal.fromJson(goalJSON);
      subGoalsList.add(newGoal);
    }

    return Goal(
      json['name'],
      json['isComplete'],
      subgoals: subGoalsList,
    );
  }

  Map<String, dynamic> toJson() {
    return _goalToJson(this);
  }

  Map<String, dynamic> _goalToJson(Goal instance) {
    List subGoalJSONs = List.empty(growable: true);
    for (Goal subgoal in instance.subGoals) {
      subGoalJSONs.add(subgoal.toJson());
    }
    return <String, dynamic>{
      'name': instance.name,
      'isComplete': instance.isComplete,
      'subgoals': subGoalJSONs,
    };
  }

  @override
  String toString() {
    String toPrint = "";
    toPrint += "Goal\nIs Complete: $isComplete\n$name\nSubgoals:\n";
    for (Goal currGoal in subGoals) {
      toPrint += currGoal.toString();
    }
    return toPrint;
  }
}
