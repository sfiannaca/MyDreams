import 'package:isar/isar.dart';

part 'book_model.g.dart';

@Collection()
class BookModel {
  Id id = Isar.autoIncrement;

  @Index()
  String title = '';
  String meaning = "";
}
