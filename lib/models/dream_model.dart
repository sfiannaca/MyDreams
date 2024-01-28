import 'package:isar/isar.dart';

part 'dream_model.g.dart';

@Collection()
class DreamModel {
  Id id = Isar.autoIncrement;

  String description = '';
  String title = "";
  String analysis = "";
  String notes = "";
  bool stared = false;
  bool recurrent = false;
  bool nightmare = false;
  DateTime timestamp = DateTime.now();
  List<String> emotions = [];
}
