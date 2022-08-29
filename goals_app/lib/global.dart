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
    Priority parentPriority =
        userPriorities.elementAt(goalToRemove.currPriorityIndex);
    debugPrint("Hey this priority is" + parentPriority.name);

    var allPriorities =
        FirebaseFirestore.instance.collection(databaseUserString);
    allPriorities.snapshots().forEach((element) {
      for (var doc in element.docs) {
        Priority currPriority = Priority.fromJson(doc.data());
        if (currPriority.name == parentPriority.name) {
          List goalsJSONs = doc['goals'];
          debugPrint("Length before " + goalsJSONs.length.toString());

          int index = 0;
          for (var goalJson in goalsJSONs) {
            if (goalJson['name'] == goalToRemove.name) {
              goalsJSONs.removeAt(index);
            }
            index++;
          }
          debugPrint("Length after " + goalsJSONs.length.toString());

          doc.reference.update({
            'name': doc['name'],
            'imageUrl': doc['imageUrl'],
            'goals': goalsJSONs,
          });
        }

        // Priority currPriority = Priority.fromJson(doc.data());
        // if (currPriority.name == parentPriority.name) {
        //   debugPrint("We want to delete " +
        //       goalToRemove.name +
        //       " in priority " +
        //       parentPriority.name);
        // FirebaseFirestore.instance
        //     .runTransaction((Transaction myTransaction) async {
        //   myTransaction.delete(doc.reference);
        // });
        //}
      }
    });
    return removeGoal(goalToRemove.currPriorityIndex, goalToRemove);
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
    //With Internet connection
    // FirebaseFirestore.instance.collection(databaseUserString).add(
    //       newPriority.toJson(),
    //     );
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
            updatePriorityIndexes();
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
        Priority currPriority = Priority.fromJson(doc.data());

        //This function may not be giving the expected result
        int currIndex = userPriorities.indexWhere((element) {
          debugPrint("Element Name : " + element.name);
          debugPrint("currPri Name : " + currPriority.name + "\n");

          return element.name == currPriority.name;
        });
        debugPrint("Curr Index: " + currIndex.toString());

        //Indexes not updating correctly
        //TODO Figure out why it's failing

        //Assuming that not found == -1
        if (currIndex != -1) {
          //debugPrint("we want to update" + currPriority.name);
          //no, but it's coming here, so looks like the indexWhere is working as
          //it should
          try {
            //My thoughts on potential errors
            //1. Maybe the doc.get isn't right
            //2. maybe update needs all the fields
            //3. Maybe need to find a way to ensure that the deleting
            //is done before the updating of the indexes starts

            //It must be this doc check I think
            //maybe just need the doc.get('name')
            //or maybe a different check than .exists
            //maybe doc.get() isn't even the right
            //way to check if it's there
            //Or maybe the best way to solve this is to make sure
            //that the deletion is complete before starting on the reindexing
            //or is there a better way to do indexing
            //hmm. Probably shouldn't use the indexes in the collection
            //because that is random, so probably using this method of updating after
            //each deletion is probably best, but looks like it could be optimized
            //Do I need to provide all fields for the update to work correctly?
            var docCheck = await doc.get('name').exists;
            debugPrint(docCheck);
            if (docCheck) {
              doc.reference.update({
                'name': doc['name'],
                'priorityIndex': currIndex + 1,
              });
            }
          } catch (e) {
            //debugPrint("Tried to update " + currPriority.name);
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
    // FirebaseFirestore.instance
    //     .collection(databaseUserString)
    //     .snapshots()
    //     .listen((data) {
    //   var allPrioritiesDocs = data.docs;
    //   int index = 0;
    //   for (var currPriorityDoc in allPrioritiesDocs) {
    //     Priority newPriority = Priority.fromJson(currPriorityDoc.data());
    //     String newPriorityName = newPriority.name;
    //     bool isFound = false;
    //     for (Priority element in userPriorities) {
    //       if (element.name == newPriorityName) {
    //         isFound = true;
    //       }
    //     }
    //     if (!isFound) {
    //       userPriorities.add(newPriority);
    //     }

    //     index++;
    //   }
    // });
    // userPriorities.sort((a, b) => a.priorityIndex.compareTo(b.priorityIndex));

    //if (userPriorities.isEmpty) {
    //   userPriorities.add(
    //     Priority(
    //         "Social",
    //         listOfStudyPictures[listOfStudyPictures.length - 1].url,
    //         priority1Goals),
    //   );
    List<Goal> emptyGoalsList = List.empty(growable: true);
    userPriorities.add(
      Priority("Physical", listOfHobbyPictures[0].url, emptyGoalsList, 1),
    );

    userPriorities.add(
      Priority("Intellectual", listOfStudyPictures[0].url, emptyGoalsList, 2),
    );

    userPriorities.add(
      Priority(
          "Emotional",
          listOfNaturePictures[listOfNaturePictures.length - 1].url,
          emptyGoalsList,
          3),
    );

    userPriorities.add(
      Priority("Spiritual", listOfNaturePictures[1].url, emptyGoalsList, 4),
    );

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
