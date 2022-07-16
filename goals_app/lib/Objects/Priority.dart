class Priority {
  String imageUrl;
  String name;
  Priority(this.name, this.imageUrl);

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
