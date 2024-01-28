import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/models/filter_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:path_provider/path_provider.dart';

class DbProvider extends ChangeNotifier {
  late Future<Isar> db;

  DbProvider() {
    db = initialize();
  }

  Future<void> saveDream(DreamModel dream) async {
    // save or edit
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.dreamModels.putSync(dream));
  }

  Stream<List<DreamModel>> searchAndWatchBy(
      String query, FilterModel filters) async* {
    final isar = await db;
    yield* isar.dreamModels
        .filter()
        .optional((filters.onlyEmptyAnalisys), (q) => q.analysisIsEmpty())
        .and()
        .optional(filters.onlyStared != null,
            (q) => q.staredEqualTo(filters.onlyStared!))
        .and()
        .anyOf(
            filters.byEmotions, (q, String e) => q.emotionsElementContains(e))
        .and()
        .optional(filters.onlyNightmare != null,
            (q) => q.nightmareEqualTo(filters.onlyNightmare!))
        .and()
        .optional(filters.onlyRecurrent != null,
            (q) => q.recurrentEqualTo(filters.onlyRecurrent!))
        .and()
        .group((q) => q
            .descriptionContains(query, caseSensitive: false)
            .or()
            .analysisContains(query, caseSensitive: false)
            .or()
            .notesContains(query, caseSensitive: false)
            .or()
            .titleContains(query, caseSensitive: false))
        .optional((filters.reverseList), (q) => q.sortByTimestampDesc())
        .watch(fireImmediately: true);
  }

  Stream<List<DreamModel>> watchBy(FilterModel query) async* {
    final isar = await db;

    yield* isar.dreamModels
        .filter()
        .optional((query.onlyEmptyAnalisys), (q) => q.analysisIsEmpty())
        .and()
        .optional(
            query.onlyStared != null, (q) => q.staredEqualTo(query.onlyStared!))
        .and()
        .anyOf(query.byEmotions, (q, String e) => q.emotionsElementContains(e))
        .and()
        .optional(query.onlyNightmare != null,
            (q) => q.nightmareEqualTo(query.onlyNightmare!))
        .and()
        .optional(query.onlyRecurrent != null,
            (q) => q.recurrentEqualTo(query.onlyRecurrent!))
        .optional(
            (true),
            (q) => query.reverseList
                ? q.sortByTimestampDesc()
                : q.sortByTimestamp())
        .watch(fireImmediately: true);
  }

  Stream<List<DreamModel>> watchDreams() async* {
    final isar = await db;
    yield* isar.dreamModels.where().watch(fireImmediately: true);
  }

  Stream<List<BookModel>> searchBooksAndWatchBy(String query) async* {
    final isar = await db;
    yield* isar.bookModels
        .filter()
        .meaningContains(query, caseSensitive: false)
        .or()
        .titleContains(query, caseSensitive: false)
        .sortByTitle()
        .watch(fireImmediately: true);
  }

  Stream<List<BookModel>> watchBooks() async* {
    final isar = await db;
    yield* isar.bookModels.where().sortByTitle().watch(fireImmediately: true);
  }

  Future<void> saveBook(BookModel book) async {
    // save or edit
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.bookModels.putSync(book));
  }

  Future<void> deleteBook(BookModel book) async {
    final isar = await db;
    await isar.writeTxn(() => isar.bookModels.delete(book.id));
  }

  Future<List<BookModel>> getBooks() async {
    final isar = await db;
    return await isar.bookModels.where().sortByTitle().findAll();
  }

  Future<List<DreamModel>> getDreams() async {
    final isar = await db;
    return await isar.dreamModels.where().sortByTimestampDesc().findAll();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<void> deleteDream(DreamModel dream) async {
    final isar = await db;
    await isar.writeTxn(() => isar.dreamModels.delete(dream.id));
  }

  Future<Isar> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return db = Isar.open([DreamModelSchema, BookModelSchema],
          inspector: false, directory: dir.path);
    } else {
      return db = Future.value(Isar.getInstance());
    }
  }
}
