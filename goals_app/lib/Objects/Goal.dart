class Goal {
  String name;
  String goalProgress;
  String goalTarget;

  String? whyToComplete;
  String? whenToComplete;
  String? whereToComplete;

  List<Goal> subGoals = List.empty(growable: true);

  Goal(this.name, this.goalProgress, this.goalTarget, this.whyToComplete,
      this.whenToComplete, this.whereToComplete);

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
    return "Goal\nName: $name\nCurrent Progress: $goalProgress out of $goalTarget\nGoal Why: $whyToComplete\nGoal Why: $whereToComplete\nGoal Why: $whenToComplete";
  }
}
