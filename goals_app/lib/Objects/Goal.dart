class Goal {
  String name;
  String goalProgress;
  String goalTarget;
  int currPriorityIndex;
  bool isChildGoal;

  String? completeByDate;
  String? reward;
  String? whyToComplete;
  String? whenToComplete;

  List<Goal> subGoals = List.empty(growable: true);

  Goal(this.name, this.currPriorityIndex, this.goalProgress, this.goalTarget,
      this.whyToComplete, this.whenToComplete, this.isChildGoal);

  setName(String newName) {
    name = newName;
  }

  setGoalProgress(String goalProgress) {
    this.goalProgress = goalProgress;
  }

  setGoalTarget(String goalTarget) {
    this.goalTarget = goalTarget;
  }

  setWhyToComplete(String whyToComplete) {
    this.whyToComplete = whyToComplete;
  }

  setWhenToComplete(String whenToComplete) {
    this.whenToComplete = whenToComplete;
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      json['name'],
      json['currPriorityIndex'],
      json['goalProgress'],
      json['goalTarget'],
      json['whyToComplete'],
      json['whenToComplete'],
      json['isChildGoal'],
    );
  }

  Map<String, dynamic> toJson() => _goalToJson(this);

  Map<String, dynamic> _goalToJson(Goal instance) => <String, dynamic>{
        'name': instance.name,
        'goalProgress': instance.goalProgress,
        'goalTarget': instance.goalTarget,
        'currPriorityIndex': instance.currPriorityIndex,
        'isChildGoal': instance.isChildGoal,
        'completeByDate': instance.completeByDate,
        'reward': instance.reward,
        'whyToComplete': instance.whyToComplete,
        'whenToComplete': instance.whenToComplete,
      };

  @override
  String toString() {
    String toPrint = "";
    toPrint +=
        "Goal\nName: $name\nCurrent Progress: $goalProgress out of $goalTarget\nGoal Why: $whyToComplete\nGoal When&Where: $whenToComplete\nIs Child: $isChildGoal\nTo complete by: $completeByDate\nReward: $reward\n";
    for (Goal currGoal in subGoals) {
      toPrint += currGoal.toString();
    }
    return toPrint;
  }
}
