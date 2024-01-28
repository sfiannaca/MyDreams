import 'dart:io';
import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/models/export_model.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StorageHelper {
  Future<String?> pickDirectory() async {
    String? path = await FilePicker.platform.getDirectoryPath();

    await _checkPermission(Permission.storage);
    await _checkPermission(Permission.manageExternalStorage);

    return path;
  }

  Future<List<ExportModel>> pickBackup() async {
    if (!Platform.isLinux) {
      await _checkPermission(Permission.storage);
      await _checkPermission(Permission.manageExternalStorage);
    }

    if (Platform.isAndroid || Platform.isIOS) {
      FilePicker.platform.clearTemporaryFiles();
    }

    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (file == null) return [];

    try {
      final path = file.files.single.path ?? "";
      var fileBytes = File(path).readAsBytesSync();
      final excel = Excel.decodeBytes(fileBytes);
      return await _convertExcelToList(excel);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  void exportBackup(BuildContext context, String path,
      List<DreamModel> firstRows, List<BookModel> secondRows) async {
    final excel = Excel.createExcel();
    Sheet sheetObject = excel[excel.getDefaultSheet().toString()];

    final labels = [
      "id",
      "Title",
      "Description",
      "Analisys",
      "Notes",
      "Emotions",
      "Recurrent",
      "Nightmare",
      "Stared",
      "Date",
      "",
      "id",
      "Symbol",
      "Meaning",
    ];

    // Header
    for (var i = 0; i < labels.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(labels[i]);
    }

    // Body
    for (var i = 1; i < firstRows.length + 1; i++) {
      var index = i - 1; // for skip header
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
          .value = TextCellValue(firstRows[index].id.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
          .value = TextCellValue(firstRows[index].title.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
          .value = TextCellValue(firstRows[index].description.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
          .value = TextCellValue(firstRows[index].analysis.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
          .value = TextCellValue(firstRows[index].notes.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
          .value = TextCellValue(firstRows[index].emotions.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
          .value = TextCellValue(firstRows[index].recurrent.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
          .value = TextCellValue(firstRows[index].nightmare.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
          .value = TextCellValue(firstRows[index].stared.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i))
          .value = TextCellValue(firstRows[index].timestamp.toString());
    }

    for (var i = 1; i < secondRows.length + 1; i++) {
      var index = i - 1; // for skip header
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i))
          .value = TextCellValue(secondRows[index].id.toString());

      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i))
          .value = TextCellValue(secondRows[index].title.toString());
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i))
          .value = TextCellValue(secondRows[index].meaning.toString());
    }

    final fileBytes = excel.save();

    try {
      File(("$path/backup.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      Utils().customSnackBar(
          context, AppLocalizations.of(context)!.successFileSaved);
    } catch (e) {
      debugPrint(e.toString());
      Utils()
          .customSnackBar(context, AppLocalizations.of(context)!.warnNotSaved);
    }
  }

  void saveBooksToText(
      BuildContext context, String path, List<BookModel> books) async {
    final fileName = AppLocalizations.of(context)!.books;
    final file = File('$path/$fileName.txt');
    final outputBuffer = StringBuffer();

    for (final book in books) {
      outputBuffer.writeln(
          "[${book.title.isNotEmpty ? book.title : AppLocalizations.of(context)!.book}]");
      outputBuffer.writeln("${book.meaning}\n");
    }

    try {
      file.writeAsString(outputBuffer.toString());
      Utils().customSnackBar(
          context, AppLocalizations.of(context)!.successFileSaved);
    } catch (e) {
      debugPrint(e.toString());
      Utils().customSnackBar(context, AppLocalizations.of(context)!.warnError);
    }
  }

  void saveDreamsToText(
      BuildContext context, String path, List<DreamModel> dreams) {
    final fileName = AppLocalizations.of(context)!.dreams;
    final file = File('$path/$fileName.txt');
    final StringBuffer outputBuffer = StringBuffer();

    for (DreamModel dream in dreams) {
      final timestamp =
          Utils().createDateTimeString(dream.timestamp, context, false);
      final title = dream.title.isNotEmpty
          ? dream.title
          : AppLocalizations.of(context)!.dream;

      outputBuffer.writeln(timestamp);
      outputBuffer.writeln("[$title]");
      outputBuffer.writeln(dream.description);

      if (dream.analysis.isNotEmpty) {
        outputBuffer.writeln("{${AppLocalizations.of(context)!.analisys}]");
        outputBuffer.writeln(dream.analysis);
      }

      if (dream.notes.isNotEmpty) {
        outputBuffer.writeln("[${AppLocalizations.of(context)!.notes}]");
        outputBuffer.writeln(dream.notes);
      }

      if (dream.emotions.isNotEmpty) {
        outputBuffer.writeln("[${AppLocalizations.of(context)!.emotions}]");
        outputBuffer.writeln(dream.emotions.join(' '));
      }

      if (dream.recurrent || dream.nightmare) {
        outputBuffer.writeln("[${AppLocalizations.of(context)!.tags}]");
        if (dream.recurrent) {
          outputBuffer.write(AppLocalizations.of(context)!.recurrent);
        }
        if (dream.nightmare) {
          outputBuffer.write(AppLocalizations.of(context)!.nightmare);
        }
        outputBuffer.writeln();
      }

      outputBuffer.writeln('\n');
    }

    try {
      file.writeAsString(outputBuffer.toString());
      Utils().customSnackBar(
          context, AppLocalizations.of(context)!.successFileSaved);
    } catch (e) {
      debugPrint(e.toString());
      Utils().customSnackBar(context, AppLocalizations.of(context)!.warnError);
    }
  }

  Future<List<ExportModel>> _convertExcelToList(Excel excel) async {
    List<DreamModel> dreamsList = [];
    List<BookModel> booksList = [];
    for (var table in excel.tables.keys) {
      final maxRows = excel.tables[table]!.maxRows;

      for (var i = 1; i < maxRows; i++) {
        final id = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
            .value
            .toString();
        final title = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
            .value
            .toString();
        final description = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
            .value
            .toString();
        final analysis = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
            .value
            .toString();
        final notes = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
            .value
            .toString();
        final emotions = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
            .value
            .toString();
        final recurrent = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
            .value
            .toString();
        final nightmare = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
            .value
            .toString();
        final stared = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
            .value
            .toString();
        final timestamp = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i))
            .value
            .toString();

        final bookId = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i))
            .value
            .toString();

        final bookTitle = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i))
            .value
            .toString();

        final bookMeaning = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i))
            .value
            .toString();

        final cleanListFromArray =
            emotions.replaceAll("[", "").replaceAll("]", "");

        var arrFromString = cleanListFromArray.split(", ");

        arrFromString.removeWhere((element) => element.isEmpty);

        final dream = DreamModel()
          ..id = double.parse(id).toInt()
          ..title = title
          ..analysis = analysis
          ..description = description
          ..notes = notes
          ..emotions = arrFromString
          ..recurrent = recurrent == "false" ? false : true
          ..nightmare = nightmare == "false" ? false : true
          ..stared = stared == "false" ? false : true
          ..timestamp = DateTime.parse(timestamp);
        dreamsList.add(dream);

        if (bookId != "null") {
          final book = BookModel()
            ..id = double.parse(bookId).toInt()
            ..title = bookTitle
            ..meaning = bookMeaning;
          booksList.add(book);
        }
      }
    }

    final lists = ExportModel()
      ..books = booksList
      ..dreams = dreamsList;
    return [lists];
  }

  Future _checkPermission(Permission permission) async {
    if (await permission.isGranted) return;
    await permission.request();
  }
}
