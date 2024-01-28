class FilterModel {
  bool reverseList = true;
  bool onlyEmptyAnalisys = false;
  bool? onlyStared;
  bool? onlyRecurrent;
  bool? onlyNightmare;
  List<String> byEmotions = [];

  isActive() {
    return byEmotions.isNotEmpty ||
        onlyStared != null ||
        onlyEmptyAnalisys ||
        onlyRecurrent != null ||
        onlyNightmare != null;
  }
}
