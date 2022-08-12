import '../../Objects/Goal.dart';

class NewGoalArguments {
  final int priorityIndex;
  final bool isComingFromPriority;
  late Goal currentGoal;
  NewGoalArguments(this.priorityIndex, this.isComingFromPriority,
      {Goal? currentGoal}) {
    if (currentGoal != null) {
      this.currentGoal = currentGoal;
    }
  }

  get currPriorityIndex => null;
}
