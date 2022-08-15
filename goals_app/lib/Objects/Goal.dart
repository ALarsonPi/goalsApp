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
  String? whereToComplete;

  List<Goal> subGoals = List.empty(growable: true);

  Goal(
      this.name,
      this.currPriorityIndex,
      this.goalProgress,
      this.goalTarget,
      this.whyToComplete,
      this.whenToComplete,
      this.whereToComplete,
      this.isChildGoal);

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

  setWhereToComplete(String whereToComplete) {
    this.whereToComplete = whereToComplete;
  }

  @override
  String toString() {
    String toPrint = "";
    toPrint +=
        "Goal\nName: $name\nCurrent Progress: $goalProgress out of $goalTarget\nGoal Why: $whyToComplete\nGoal Where: $whereToComplete\nGoal When: $whenToComplete\nIs Child: $isChildGoal\nTo complete by: $completeByDate\nReward: $reward\n";
    for (Goal currGoal in subGoals) {
      toPrint += currGoal.toString();
    }
    return toPrint;
  }
}
