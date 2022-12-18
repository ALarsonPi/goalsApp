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
    notifyListeners();
  }

  movePriorityToExpanded(int oldIndex, int newIndex) {
    if (newIndex == priorities.length) newIndex--;
    if (newIndex < oldIndex) newIndex++;
    Priority currPriority = priorities.elementAt(oldIndex);
    removePriorityAt(oldIndex);
    addPriorityAt(newIndex, currPriority);
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
    notifyListeners();
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

  updateGoalCompletion(Priority priority, Goal goal, bool isComplete) {
    priorities
        .elementAt(priorities.indexOf(priority))
        .goals
        .elementAt(priorities
            .elementAt(priorities.indexOf(priority))
            .goals
            .indexOf(goal))
        .isComplete = isComplete;
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  updateGoalName(Priority priority, Goal goal, String newName) {
    priorities
        .elementAt(priorities.indexOf(priority))
        .goals
        .elementAt(priorities
            .elementAt(priorities.indexOf(priority))
            .goals
            .indexOf(goal))
        .name = newName;
    writeCurrPrioritiesToFile();
    notifyListeners();
  }

  removeGoalFromPriority(Priority priority, Goal goalToRemove) {
    priorities
        .elementAt(priorities.indexOf(priority))
        .goals
        .remove(goalToRemove);

    List<Goal> goalList = List.empty(growable: true);
    goalList.addAll(priorities.elementAt(priorities.indexOf(priority)).goals);
    priorities.elementAt(priorities.indexOf(priority)).goals.clear();
    priorities.elementAt(priorities.indexOf(priority)).goals.addAll(goalList);
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
}
