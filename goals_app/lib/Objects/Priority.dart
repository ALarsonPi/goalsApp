import 'Goal.dart';

class Priority {
  String imageUrl;
  String name;
  List<Goal> goals = List.empty(growable: true);
  Priority(this.name, this.imageUrl, this.goals);

  setName(String newName) {
    name = newName;
  }

  setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  @override
  String toString() {
    String toPrint = "";
    toPrint += "Priority\nName: $name\n$imageUrl\n";
    for (int i = 0; i < goals.length; i++) {
      toPrint += goals[i].toString();
    }
    return toPrint;
  }
}
