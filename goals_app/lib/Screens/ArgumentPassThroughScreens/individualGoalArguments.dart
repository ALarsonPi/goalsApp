import 'package:goals_app/Objects/Goal.dart';

class IndividualGoalArguments {
  final Goal currGoal;
  final int currPriorityIndex;
  bool comingFromListView;

  setComingFromListView(bool newValue) {
    //Basically just over ride it
    //in this instance
    comingFromListView = newValue;
  }

  IndividualGoalArguments(
      this.currGoal, this.currPriorityIndex, this.comingFromListView);
}
