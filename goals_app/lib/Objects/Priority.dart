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
    return "Priority\nName: $name\n$imageUrl";
  }
}
