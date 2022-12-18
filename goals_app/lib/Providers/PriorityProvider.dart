import 'package:flutter/material.dart';
import 'package:goals_app/Settings/global.dart';
import '../Models/Goal.dart';
import '../Models/Priority.dart';
import '../Settings/GlobalFileIO.dart';

class PriorityProvider extends ChangeNotifier {
  List<Priority> priorities = List.empty(growable: true);

  writeCurrPrioritiesToFile() {
    GlobalFileIO.writePrioritiesToMemory(priorities);
  }

  addPrioritiesFromListFromFile() {
    priorities.clear();
    priorities.addAll(Global.listOfPrioritiesFromFile);
    writeCurrPrioritiesToFile();
  }

  movePriority(Priority priorityToMove, Priority otherPriority) {
    movePriorityTo(
        priorities.indexOf(priorityToMove), priorities.indexOf(otherPriority));
  }

  movePriorityTo(int oldIndex, int newIndex) {
    if (newIndex == priorities.length) newIndex--;
    Priority currPriority = priorities.elementAt(oldIndex);
    removePriorityAt(oldIndex);
    addPriorityAt(newIndex, currPriority);

    Global.listOfPrioritiesFromFile.clear();
    Global.listOfPrioritiesFromFile.addAll(priorities);

    updatePriorityIndexes();
    notifyListeners();
  }

  movePriorityToExpanded(int oldIndex, int newIndex) {
    if (newIndex == priorities.length) newIndex--;
    if (newIndex < oldIndex) newIndex++;
    Priority currPriority = priorities.elementAt(oldIndex);
    removePriorityAt(oldIndex);
    addPriorityAt(newIndex, currPriority);
    updatePriorityIndexes();
    notifyListeners();
  }

  swapPriorities(Priority priorityOne, Priority priorityTwo) {
    swapPrioritiesAt(
        priorities.indexOf(priorityOne), priorities.indexOf(priorityTwo));
    notifyListeners();
  }

  swapPrioritiesAt(int indexOne, int indexTwo) {
    final Priority temp = priorities[indexOne];
    priorities[indexOne] = priorities[indexTwo];
    priorities[indexTwo] = temp;
    updatePriorityIndexes();
    notifyListeners();
  }

  correctPriorityProgressInTree(
      int indexOfPriorityToCorrect, bool shouldCorrectTarget) {
    Priority currPriority = priorities.elementAt(indexOfPriorityToCorrect);

    correctPriorityProgressRecursiveHelper(
        currPriority.goals, shouldCorrectTarget);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  correctPriorityProgressRecursiveHelper(
      List<Goal> subgoals, bool shouldCorrectTarget) {
    for (Goal goal in subgoals) {
      if (goal.subGoals.isEmpty) return;
      correctPriorityProgressRecursiveHelper(
          goal.subGoals, shouldCorrectTarget);

      goal.goalProgress = getSumOfChildrenProgress(goal).toString();
      if (shouldCorrectTarget) {
        goal.goalTarget = getSumOfChildrenTarget(goal).toString();
      }
    }
  }

  int getSumOfChildrenProgress(Goal goal) {
    return getSumOfChildrenRecursiveHelper(goal.subGoals, 0, true);
  }

  int getSumOfChildrenTarget(Goal goal) {
    return getSumOfChildrenRecursiveHelper(goal.subGoals, 0, false);
  }

  int getSumOfChildrenRecursiveHelper(
      List<Goal> subGoals, int currTotal, bool forProgress) {
    for (Goal currGoal in subGoals) {
      if (currGoal.subGoals.isEmpty) {
        if (forProgress) {
          currTotal += int.parse(currGoal.goalProgress);
        } else {
          currTotal += int.parse(currGoal.goalTarget);
        }
      } else {
        currTotal += getSumOfChildrenRecursiveHelper(
            currGoal.subGoals, currTotal, forProgress);
      }
    }
    return currTotal;
  }

  addGoalToPriority(Priority priority, Goal newGoal) {
    priorities.elementAt(priorities.indexOf(priority)).goals.add(newGoal);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  addGoalToPriorityAt(int priorityIndex, Goal newGoal) {
    priorities.elementAt(priorityIndex).goals.add(newGoal);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  removeGoalFromPriority(Priority priority, Goal goalToRemove) {
    priorities
        .elementAt(priorities.indexOf(priority))
        .goals
        .remove(goalToRemove);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  removeGoalFromPriorityAt(int priorityIndex, Goal goalToRemove) {
    priorities.elementAt(priorityIndex).goals.remove(goalToRemove);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  bool removeTopLevelGoal(Goal goalToRemove) {
    bool wasInTopLevel = false;
    for (Priority currPriority in priorities) {
      if (currPriority.goals.contains(goalToRemove)) {
        currPriority.goals.remove(goalToRemove);
        wasInTopLevel = true;
      }
    }

    writeCurrPrioritiesToFile();
    notifyListeners();

    return wasInTopLevel;
  }

  bool removeGoal(int currPriorityIndex, Goal goalToRemove) {
    List<Goal> priorityGoals = priorities.elementAt(currPriorityIndex).goals;
    //If we find the goal is directly in the priority, remove it there
    if (priorityGoals.contains(goalToRemove)) {
      priorities.elementAt(currPriorityIndex).goals.remove(goalToRemove);
      writeCurrPrioritiesToFile();
      return true;
    }

    //if not, it's a child of another goal, and we need to find it in the tree
    //If it's never found, return true so we just navegate back to the main priority
    recursiveRemoveGoalHelper(
        priorities[currPriorityIndex].goals, goalToRemove);

    writeCurrPrioritiesToFile();
    notifyListeners();
    return !isFoundRecursively;
  }

  bool isFoundRecursively = false;
  recursiveRemoveGoalHelper(List<Goal> goalsList, Goal goalToRemove) {
    for (Goal currGoal in goalsList) {
      if (currGoal.subGoals.isNotEmpty) {
        int subGoalIndex = 0;
        for (Goal subGoal in currGoal.subGoals) {
          if (subGoal == goalToRemove) {
            currGoal.subGoals.removeAt(subGoalIndex);
            int currentGoalTarget = int.parse(currGoal.goalTarget);
            if (currentGoalTarget != 1) {
              currGoal.setGoalTarget((currentGoalTarget - 1).toString());
            }
            isFoundRecursively = true;
            return true;
          }
          subGoalIndex++;
        }
        recursiveRemoveGoalHelper(currGoal.subGoals, goalToRemove);
      }
    }
    return false;
  }

  bool getGoalParentRecursiveHelper(List<Goal> subGoals, Goal childGoal) {
    for (Goal goal in subGoals) {
      if (goal.subGoals.contains(childGoal)) {
        return true;
      }
      getGoalParentRecursiveHelper(goal.subGoals, childGoal);
    }
    return false;
  }

  setAllPriorities(List<Priority> prioritiesFromFile) {
    priorities.addAll(prioritiesFromFile);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  addPriority(Priority newPriority) {
    priorities.add(newPriority);
    Global.listOfPrioritiesFromFile.add(newPriority);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  addPriorityAt(int indexToInsertAt, Priority newPriority) {
    priorities.insert(indexToInsertAt, newPriority);
    Global.listOfPrioritiesFromFile.insert(indexToInsertAt, newPriority);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  removePriority(Priority priorityToRemove) {
    priorities.remove(priorityToRemove);
    Global.listOfPrioritiesFromFile.remove(priorityToRemove);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  removePriorityAt(int indexOfPriorityToRemove) {
    priorities.removeAt(indexOfPriorityToRemove);
    Global.listOfPrioritiesFromFile.removeAt(indexOfPriorityToRemove);
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  updatePriorityIndexes() {
    for (int i = 0; i < priorities.length; i++) {
      priorities[i].priorityIndex = i;
      updateGoalPrioritiesInAppData(priorities[i], i);
    }
    writeCurrPrioritiesToFile();
  }

  updateGoalPrioritiesInAppData(Priority parentPriority, int correctIndex) {
    recursiveUpdateGoalPriorityIndexHelper(parentPriority.goals, correctIndex);
  }

  recursiveUpdateGoalPriorityIndexHelper(
      List<Goal> goalsList, int correctPriorityIndex) {
    //for every goal, if it's priorityIndex is wrong, fix it
    //if a goal has a subgoal, do the same for it's subgoals
    for (Goal currGoal in goalsList) {
      currGoal.currPriorityIndex = correctPriorityIndex;
      if (currGoal.subGoals.isNotEmpty) {
        recursiveUpdateGoalPriorityIndexHelper(
            currGoal.subGoals, correctPriorityIndex);
      }
    }
  }
}
