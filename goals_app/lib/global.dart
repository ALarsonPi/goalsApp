import 'package:flutter/cupertino.dart';

import 'Objects/Priority.dart';
import 'Objects/Goal.dart';

class Global {
  static Map listOfImageLists = {
    "Nature/Animal Images": listOfNaturePictures,
    "Activities": listOfHobbyPictures,
    "Study Images": listOfStudyPictures,
    "Food Images": listOfFoodPictures,
  };

  static List<pictureHolder> listOfNaturePictures = [
    pictureHolder("https://placedog.net/900/1200?id=36", "Dog Image 1"),
    pictureHolder(
        "https://images.unsplash.com/photo-1657199372069-bd8cb49315c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=80",
        "Mountain"),
    pictureHolder("https://picsum.photos/id/237/1200/800", "Dog"),
    pictureHolder("https://picsum.photos/id/191/500/600", "Road"),
    pictureHolder("https://picsum.photos/id/1039/500/600", "Forest"),
    pictureHolder("https://picsum.photos/id/152/500/600", "Flowers"),
    pictureHolder("https://placedog.net/800/640?id=177", "Dog Image 2"),
  ];

  static List<pictureHolder> listOfFoodPictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        "Stir Fry and Orange Juice"),
    pictureHolder(
        "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        "Pancakes"),
    pictureHolder(
        "https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        'French Toast'),
    pictureHolder("https://picsum.photos/id/312/500/600", "Honey"),
    pictureHolder(
        "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Healthy Pasta"),
    pictureHolder("https://picsum.photos/id/1080/500/600", "Strawberries"),
    pictureHolder(
        "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Veggies on Display"),
  ];

  static List<pictureHolder> listOfStudyPictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1472745433479-4556f22e32c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHJlYWRpbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Reading on Bench"),
    pictureHolder("https://picsum.photos/id/3/800/800", "Tech"),
    pictureHolder("https://picsum.photos/id/367/800/800", "Kindle"),
    pictureHolder("https://picsum.photos/id/180/500/800", "Laptop Study"),
    pictureHolder(
        "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHJlYWRpbmd8ZW58MHx8MHx8&auto=format&&w=1600&q=60",
        "SpiderMan Reading"),
    pictureHolder("https://picsum.photos/id/24/500/800", "Book"),
    pictureHolder("https://picsum.photos/id/259/800/800",
        "Dude on bench in NYC with Snow"),
  ];

  static List<pictureHolder> listOfHobbyPictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1502224562085-639556652f33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cnVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Running"),
    pictureHolder(
        "https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Volleyball"),
    pictureHolder(
        "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Lifting weights"),
    pictureHolder(
        "https://images.unsplash.com/photo-1560272564-c83b66b1ad12?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Soccer"),
    pictureHolder(
        "https://images.unsplash.com/photo-1493225255756-d9584f8606e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3VyZmluZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        "Surfing"),
    pictureHolder(
        "https://images.unsplash.com/photo-1557685888-2d3621ddf615?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzV8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Rock Climbing"),
    pictureHolder(
        "https://images.unsplash.com/photo-1565992441121-4367c2967103?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c3BvcnR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Ski-ing"),
    pictureHolder(
        "https://images.unsplash.com/photo-1560089000-7433a4ebbd64?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjh8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Swimming"),
  ];

  static List<Priority> userPriorities = List.empty(growable: true);
  static CustomStack<Goal> depthStack = CustomStack();
  static bool goalButtonsInGridView = false;
  static bool priorityIsInListView = false;
  static int priorityLastOpen = -1;

  static bool removeGoal(int currPriorityIndex, Goal goalToRemove) {
    List<Goal> priorityGoals = userPriorities[currPriorityIndex].goals;
    //If we find the goal is directly in the priority, remove it there
    int index = 0;
    for (Goal currGoal in priorityGoals) {
      if (currGoal == goalToRemove) {
        userPriorities[currPriorityIndex].goals.removeAt(index);
        return true;
      }
      index++;
    }

    //if not, it's a child of another goal, and we need to find it in the tree
    //If it's never found, return true so we just navegate back to the main priority
    recursiveRemoveGoalHelper(
        userPriorities[currPriorityIndex].goals, goalToRemove);
    return !isFoundRecursively;
  }

  static bool isFoundRecursively = false;
  static recursiveRemoveGoalHelper(List<Goal> goalsList, Goal goalToRemove) {
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

  static getPriorities() {
    if (userPriorities.isEmpty) {
      List<Goal> priority1Goals = List.empty(growable: true);
      List<Goal> priority2Goals = List.empty(growable: true);
      List<Goal> priority3Goals = List.empty(growable: true);
      List<Goal> priority4Goals = List.empty(growable: true);
      List<Goal> priority5Goals = List.empty(growable: true);

      Goal exampleGoal = Goal(
          "Pray every day for 30 days",
          4,
          "17",
          "30",
          "Praying is an act of faith and acting in faith brings miracles",
          "Probably in the morning is best for me, and at night as much as I can",
          false);
      Goal exampleSubGoal1 = Goal(
          "Make sure to ask blessings on friends and fam in prayers",
          4,
          "4",
          "30",
          "Praying is an act of faith and acting in faith brings miracles",
          "Probably in the morning is best for me, and at night as much as I can",
          true);
      Goal exampleSubGoal2 = Goal(
          "Ask for things I need in life",
          4,
          "29",
          "30",
          "Praying is an act of faith and acting in faith brings miracles",
          "Probably in the morning is best for me, and at night as much as I can",
          true);
      exampleGoal.subGoals.add(exampleSubGoal1);
      exampleGoal.subGoals.add(exampleSubGoal2);

      priority5Goals.add(exampleGoal);

      userPriorities.add(
        Priority(
            "Social",
            listOfStudyPictures[listOfStudyPictures.length - 1].url,
            priority1Goals),
      );

      userPriorities.add(
        Priority("Physical", listOfHobbyPictures[0].url, priority2Goals),
      );

      userPriorities.add(
        Priority("Intellectual", listOfStudyPictures[0].url, priority3Goals),
      );

      userPriorities.add(
        Priority(
            "Emotional",
            listOfNaturePictures[listOfNaturePictures.length - 1].url,
            priority4Goals),
      );

      userPriorities.add(
        Priority("Spiritual", listOfNaturePictures[1].url, priority5Goals),
      );
    }
  }
}

class pictureHolder {
  String url;
  String description;
  pictureHolder(this.url, this.description);
}

class CustomStack<E> {
  final _list = List.empty(growable: true);

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get top => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
