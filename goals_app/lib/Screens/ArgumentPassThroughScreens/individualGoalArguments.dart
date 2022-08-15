import 'package:goals_app/Objects/Goal.dart';

class IndividualGoalArguments {
  final Goal currGoal;
  final int currPriorityIndex;
  final bool comingFromListView;
  IndividualGoalArguments(
      this.currGoal, this.currPriorityIndex, this.comingFromListView);
}
