import 'package:diaryofdreams/models/filter_model.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  final FilterModel _filters = FilterModel();
  get filters => _filters;

  void resetValues() {
    _filters.byEmotions = [];
    _filters.onlyStared = null;
    _filters.onlyRecurrent = null;
    _filters.onlyNightmare = null;
    _filters.onlyEmptyAnalisys = false;
    notifyListeners();
  }

  void reverseList(bool value) {
    if (_filters.reverseList == value) return;
    _filters.reverseList = value;
    notifyListeners();
  }

  void onlyStared(bool? value) {
    if (_filters.onlyStared == value) return;
    _filters.onlyStared = value;
    notifyListeners();
  }

  void onlyRecurrent(bool? value) {
    if (_filters.onlyRecurrent == value) return;
    _filters.onlyRecurrent = value;
    notifyListeners();
  }

  void onlyEmptyAnalisys(bool value) {
    if (_filters.onlyEmptyAnalisys == value) return;
    _filters.onlyEmptyAnalisys = value;
    notifyListeners();
  }

  void onlyNightmare(bool? value) {
    if (_filters.onlyNightmare == value) return;
    _filters.onlyNightmare = value;
    notifyListeners();
  }

  void updateByEmotions(String value) {
    _filters.byEmotions.contains(value)
        ? _filters.byEmotions.remove(value)
        : _filters.byEmotions.add(value);
    notifyListeners();
  }

  void byEmotions(List<String> value) {
    _filters.byEmotions = value;
    notifyListeners();
  }
}
