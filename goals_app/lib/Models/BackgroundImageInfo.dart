class BackgroundImageHolder {
  int lightModeIndex = 0;
  int darkModeIndex = 0;

  BackgroundImageHolder({lightIndex, darkIndex}) {
    if (lightIndex == null && darkIndex == null) {
      lightModeIndex = 0;
      darkModeIndex = 0;
    } else {
      lightModeIndex = lightIndex;
      darkModeIndex = darkIndex;
    }
  }

  Map<String, dynamic> toJson() => {
        'lightIndex': lightModeIndex,
        'darkIndex': darkModeIndex,
      };

  factory BackgroundImageHolder.fromJson(Map<String, dynamic> json) {
    return BackgroundImageHolder(
      lightIndex: json['lightIndex'],
      darkIndex: json['darkIndex'],
    );
  }
}
