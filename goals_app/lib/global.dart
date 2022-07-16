import 'Objects/Priority.dart';

class Global {
  static List<pictureHolder> listOfNaturePictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1657199372069-bd8cb49315c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1365&q=80",
        "Mountain"),
    pictureHolder("https://picsum.photos/id/292/800/800", "Veggies"),
    pictureHolder("https://picsum.photos/id/237/400/300", "Dog"),
  ];
  static List<pictureHolder> listOfCityPictures = [
    pictureHolder("https://picsum.photos/id/3/800/800", "Tech"),
    pictureHolder("https://picsum.photos/id/1067/500/800", "City"),
    pictureHolder("https://picsum.photos/id/191/500/600", "Road"),
  ];

  static List<Priority> userPriorities = List.empty(growable: true);

  static getPriorities() {
    if (userPriorities.isEmpty) {
      userPriorities.add(
        Priority("Coming closer to God", listOfNaturePictures[0].url),
      );
      userPriorities.add(
        Priority("Family", listOfNaturePictures[2].url),
      );
      userPriorities.add(
        Priority("Work", listOfCityPictures[0].url),
      );
      userPriorities.add(
        Priority("Self-Improvement", listOfNaturePictures[1].url),
      );
      userPriorities.add(
        Priority("Chillin", listOfCityPictures[2].url),
      );
    }
  }
}

class pictureHolder {
  String url;
  String description;
  pictureHolder(this.url, this.description);
}
