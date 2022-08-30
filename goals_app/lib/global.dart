import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:goals_app/Repositories/data_repository.dart';
import 'Objects/Priority.dart';
import 'Objects/Goal.dart';

class Global {
  final DataRepository dataRepo = DataRepository();

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
    List<Goal> priorityGoals =
        userPriorities.elementAt(currPriorityIndex).goals;
    //If we find the goal is directly in the priority, remove it there
    int index = 0;
    for (Goal currGoal in priorityGoals) {
      if (currGoal == goalToRemove) {
        userPriorities.elementAt(currPriorityIndex).goals.removeAt(index);
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

  static bool removeGoalFirestore(Goal goalToRemove) {
    //updateGoalPrioritiesInAppData(parentPriority, correctIndex)
    int priorityIndex = 0;
    for (Priority priority in userPriorities) {
      if (priority.goals.contains(goalToRemove)) {
        priorityIndex = priority.priorityIndex - 1;
      }
    }
    Priority parentPriority = userPriorities.elementAt(priorityIndex);

    debugPrint("Parent : " + parentPriority.name);

    var allPriorities =
        FirebaseFirestore.instance.collection(databaseUserString);
    allPriorities.snapshots().forEach((element) async {
      for (var doc in element.docs) {
        Priority currPriority = Priority.fromJson(doc.data());
        if (currPriority.name == parentPriority.name) {
          List goalsJSONs = doc['goals'];

          debugPrint("Current Priority : " + currPriority.name);

          int index = 0;
          bool isFound = false;
          debugPrint("Looking for " + goalToRemove.name);
          debugPrint("Goals JSONs length: " + goalsJSONs.length.toString());
          for (var goalJson in goalsJSONs) {
            debugPrint(goalJson['name'].toString());
            if (goalJson['name'] == goalToRemove.name) {
              isFound = true;
              break;
            }
            index++;
          }
          if (isFound) {
            goalsJSONs.removeAt(index);
            if (!goalsJSONs.contains(goalToRemove.toJson())) {
              if (doc.exists) {
                doc.reference.update({'goals': goalsJSONs});
                // await FirebaseFirestore.instance
                //     .runTransaction((Transaction myTransaction) async {
                //   myTransaction.delete(doc.reference);
                // });
              }
            }
          } else {
            debugPrint("Goal not found");
          }
        }
      }
    });
    bool returnValue = removeGoal(priorityIndex, goalToRemove);
    //if (returnValue == true) {
    //updatePrioritiesInFirebase();
    //}
    return returnValue;
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

  static addPriority(Priority newPriority) {
    userPriorities.add(newPriority);
    //Needs Internet connection
    debugPrint("Should be adding new priority");
    FirebaseFirestore.instance.collection(databaseUserString).add(
          newPriority.toJson(),
        );
    debugPrint(FirebaseFirestore.instance.collection(databaseUserString).id);
  }

  static updateGoalPrioritiesInAppData(
      Priority parentPriority, int correctIndex) {
    debugPrint("Here in update goal");
    debugPrint("Parent Priority : " + parentPriority.name);
    debugPrint("Correct index: " + correctIndex.toString());
    for (Goal currGoal in parentPriority.goals) {
      if (currGoal.currPriorityIndex != correctIndex) {
        currGoal.currPriorityIndex = correctIndex;
        debugPrint(
            "Parent Priority here after change: " + parentPriority.toString());
        debugPrint(currGoal.name);
        debugPrint("Changed priority index?");
        isFoundRecursively = true;
      } else {
        debugPrint(
            "Subgoal is already correct with index " + correctIndex.toString());
      }
    }

    recursiveUpdateGoalPriorityIndexHelper(parentPriority.goals, correctIndex);
    return parentPriority;
  }

  static recursiveUpdateGoalPriorityIndexHelper(
      List<Goal> goalsList, int correctPriorityIndex) {
    for (Goal currGoal in goalsList) {
      if (currGoal.subGoals.isNotEmpty) {
        int subGoalIndex = 0;
        for (Goal subGoal in currGoal.subGoals) {
          if (subGoal.currPriorityIndex != correctPriorityIndex) {
            subGoal.currPriorityIndex = correctPriorityIndex;
            isFoundRecursively = true;
            return true;
          } else {
            debugPrint("Subgoal is already correct with index " +
                correctPriorityIndex.toString());
          }
          subGoalIndex++;
        }
        recursiveUpdateGoalPriorityIndexHelper(
            currGoal.subGoals, correctPriorityIndex);
      }
    }
    return false;
  }

  static clearPersistence() {
    FirebaseFirestore.instance.clearPersistence();
  }

  static updatePrioritiesInFirebase() async {
    clearPersistence();
    var allPriorities =
        FirebaseFirestore.instance.collection(databaseUserString);
    allPriorities.snapshots().forEach(
      (element) {
        for (var doc in element.docs) {
          Priority currPriority = Priority.fromJson(doc.data());

          int indexOfCurrPriority = userPriorities.indexWhere((element) =>
              element.name.toString() == currPriority.name.toString());

          userPriorities[userPriorities.indexWhere((element) =>
                  element.name.toString() == currPriority.name.toString())] =
              updateGoalPrioritiesInAppData(
                  userPriorities[userPriorities.indexWhere((element) =>
                      element.name.toString() == currPriority.name.toString())],
                  indexOfCurrPriority + 1);

          List goalsJSONs = userPriorities[userPriorities.indexWhere(
                  (element) =>
                      element.name.toString() == currPriority.name.toString())]
              .getGoalsAsListofJSON();

          if (currPriority.equals(userPriorities[userPriorities.indexWhere(
              (element) =>
                  element.name.toString() == currPriority.name.toString())])) {
            continue;
          } else {
            doc.reference.update({
              'goals': goalsJSONs,
            });
          }
        }
      },
    );
  }

  static addGoalToPriority(Priority priorityOfInterest, Goal newGoal) {
    priorityOfInterest.goals.add(newGoal);

    var allPriorities =
        FirebaseFirestore.instance.collection(databaseUserString);
    allPriorities.snapshots().forEach((element) {
      for (var doc in element.docs) {
        Priority currPriority = Priority.fromJson(doc.data());
        if (currPriority.name == priorityOfInterest.name) {
          List goalsJSONs = doc['goals'];
          bool isFound = false;
          for (var goal in goalsJSONs) {
            if (goal['name'] == newGoal.name) {
              isFound = true;
            }
          }
          if (!isFound) {
            debugPrint("HEY IM here in the add goal function");
            goalsJSONs.add(newGoal.toJson());
            doc.reference.update({
              'name': doc['name'],
              'imageUrl': doc['imageUrl'],
              'goals': goalsJSONs,
            });
          }
        }
      }
    });
    updatePrioritiesInFirebase();
  }

  static removePriority(Priority priorityToRemove) async {
    int index = userPriorities.indexOf(priorityToRemove);
    userPriorities.removeAt(index);

    var allPriorities =
        FirebaseFirestore.instance.collection(databaseUserString);
    allPriorities.snapshots().forEach((element) async {
      for (var doc in element.docs) {
        Priority currPriority = Priority.fromJson(doc.data());
        if (currPriority.name == priorityToRemove.name) {
          await FirebaseFirestore.instance
              .runTransaction((Transaction myTransaction) async {
            myTransaction.delete(doc.reference);
          });
        }
      }
    });
  }

  static updatePriorityIndexes() {
    var allPriorities =
        FirebaseFirestore.instance.collection(databaseUserString);
    allPriorities.snapshots().forEach((element) async {
      for (var doc in element.docs) {
        //This may have all docs, including docs that are in
        //process of being deleted
        Priority currPriority;
        if (doc.exists && doc.data()['name'] != null) {
          currPriority = Priority.fromJson(doc.data());
        } else {
          return;
        }

        int currIndex = userPriorities.indexWhere((element) {
          return element.name == currPriority.name;
        });

        if (currIndex != -1) {
          try {
            if (doc.exists) {
              String docCheck = await doc.get('name');
              if (docCheck.isNotEmpty) {
                doc.reference.update({
                  'priorityIndex': currIndex + 1,
                });
              }
            }
          } catch (e) {
            debugPrint("Failed to update " + currPriority.name);
          }
        }
      }
    });
  }

  static String databaseUserString = 'users/randomUser1/priorities';
  static getPriorities() async {
    userPriorities.clear();

    //How to tell which user we're on?
    //Here is the code for when we have online access
    FirebaseFirestore.instance
        .collection(databaseUserString)
        .snapshots()
        .listen((data) {
      var allPrioritiesDocs = data.docs;
      int index = 0;
      for (var currPriorityDoc in allPrioritiesDocs) {
        if (currPriorityDoc.exists && currPriorityDoc.data()['name'] != null) {
          Priority newPriority = Priority.fromJson(currPriorityDoc.data());
          String newPriorityName = newPriority.name;
          bool isFound = false;
          for (Priority element in userPriorities) {
            if (element.name == newPriorityName) {
              isFound = true;
            }
          }
          if (!isFound) {
            userPriorities.add(newPriority);
          }

          index++;
        }
      }
    });
    userPriorities.sort((a, b) => a.priorityIndex.compareTo(b.priorityIndex));

    //if (userPriorities.isEmpty) {
    //   userPriorities.add(
    //     Priority(
    //         "Social",
    //         listOfStudyPictures[listOfStudyPictures.length - 1].url,
    //         priority1Goals),
    //   );
    // List<Goal> emptyGoalsList = List.empty(growable: true);
    // userPriorities.add(
    //   Priority("Physical", listOfHobbyPictures[0].url, emptyGoalsList, 1),
    // );

    // userPriorities.add(
    //   Priority("Intellectual", listOfStudyPictures[0].url, emptyGoalsList, 2),
    // );

    // userPriorities.add(
    //   Priority(
    //       "Emotional",
    //       listOfNaturePictures[listOfNaturePictures.length - 1].url,
    //       emptyGoalsList,
    //       3),
    // );

    // userPriorities.add(
    //   Priority("Spiritual", listOfNaturePictures[1].url, emptyGoalsList, 4),
    // );

    //}
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
