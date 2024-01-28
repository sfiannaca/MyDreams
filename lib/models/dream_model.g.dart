// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDreamModelCollection on Isar {
  IsarCollection<DreamModel> get dreamModels => this.collection();
}

const DreamModelSchema = CollectionSchema(
  name: r'DreamModel',
  id: -789033310879817611,
  properties: {
    r'analysis': PropertySchema(
      id: 0,
      name: r'analysis',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'emotions': PropertySchema(
      id: 2,
      name: r'emotions',
      type: IsarType.stringList,
    ),
    r'nightmare': PropertySchema(
      id: 3,
      name: r'nightmare',
      type: IsarType.bool,
    ),
    r'notes': PropertySchema(
      id: 4,
      name: r'notes',
      type: IsarType.string,
    ),
    r'recurrent': PropertySchema(
      id: 5,
      name: r'recurrent',
      type: IsarType.bool,
    ),
    r'stared': PropertySchema(
      id: 6,
      name: r'stared',
      type: IsarType.bool,
    ),
    r'timestamp': PropertySchema(
      id: 7,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _dreamModelEstimateSize,
  serialize: _dreamModelSerialize,
  deserialize: _dreamModelDeserialize,
  deserializeProp: _dreamModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dreamModelGetId,
  getLinks: _dreamModelGetLinks,
  attach: _dreamModelAttach,
  version: '3.1.0+1',
);

int _dreamModelEstimateSize(
  DreamModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.analysis.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.emotions.length * 3;
  {
    for (var i = 0; i < object.emotions.length; i++) {
      final value = object.emotions[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _dreamModelSerialize(
  DreamModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.analysis);
  writer.writeString(offsets[1], object.description);
  writer.writeStringList(offsets[2], object.emotions);
  writer.writeBool(offsets[3], object.nightmare);
  writer.writeString(offsets[4], object.notes);
  writer.writeBool(offsets[5], object.recurrent);
  writer.writeBool(offsets[6], object.stared);
  writer.writeDateTime(offsets[7], object.timestamp);
  writer.writeString(offsets[8], object.title);
}

DreamModel _dreamModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DreamModel();
  object.analysis = reader.readString(offsets[0]);
  object.description = reader.readString(offsets[1]);
  object.emotions = reader.readStringList(offsets[2]) ?? [];
  object.id = id;
  object.nightmare = reader.readBool(offsets[3]);
  object.notes = reader.readString(offsets[4]);
  object.recurrent = reader.readBool(offsets[5]);
  object.stared = reader.readBool(offsets[6]);
  object.timestamp = reader.readDateTime(offsets[7]);
  object.title = reader.readString(offsets[8]);
  return object;
}

P _dreamModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dreamModelGetId(DreamModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dreamModelGetLinks(DreamModel object) {
  return [];
}

void _dreamModelAttach(IsarCollection<dynamic> col, Id id, DreamModel object) {
  object.id = id;
}

extension DreamModelQueryWhereSort
    on QueryBuilder<DreamModel, DreamModel, QWhere> {
  QueryBuilder<DreamModel, DreamModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DreamModelQueryWhere
    on QueryBuilder<DreamModel, DreamModel, QWhereClause> {
  QueryBuilder<DreamModel, DreamModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DreamModelQueryFilter
    on QueryBuilder<DreamModel, DreamModel, QFilterCondition> {
  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> analysisEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'analysis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      analysisGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'analysis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> analysisLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'analysis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> analysisBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'analysis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      analysisStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'analysis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> analysisEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'analysis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> analysisContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'analysis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> analysisMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'analysis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      analysisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'analysis',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      analysisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'analysis',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emotions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emotions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emotions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emotions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emotions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emotions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emotions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotions',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emotions',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      emotionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> nightmareEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nightmare',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> recurrentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurrent',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> staredEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stared',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension DreamModelQueryObject
    on QueryBuilder<DreamModel, DreamModel, QFilterCondition> {}

extension DreamModelQueryLinks
    on QueryBuilder<DreamModel, DreamModel, QFilterCondition> {}

extension DreamModelQuerySortBy
    on QueryBuilder<DreamModel, DreamModel, QSortBy> {
  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByAnalysis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'analysis', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByAnalysisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'analysis', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByNightmare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nightmare', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByNightmareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nightmare', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByRecurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrent', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByRecurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrent', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByStared() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stared', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByStaredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stared', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DreamModelQuerySortThenBy
    on QueryBuilder<DreamModel, DreamModel, QSortThenBy> {
  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByAnalysis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'analysis', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByAnalysisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'analysis', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByNightmare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nightmare', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByNightmareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nightmare', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByRecurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrent', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByRecurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrent', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByStared() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stared', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByStaredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stared', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DreamModelQueryWhereDistinct
    on QueryBuilder<DreamModel, DreamModel, QDistinct> {
  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByAnalysis(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'analysis', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByEmotions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emotions');
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByNightmare() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nightmare');
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByRecurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurrent');
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByStared() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stared');
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<DreamModel, DreamModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension DreamModelQueryProperty
    on QueryBuilder<DreamModel, DreamModel, QQueryProperty> {
  QueryBuilder<DreamModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DreamModel, String, QQueryOperations> analysisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'analysis');
    });
  }

  QueryBuilder<DreamModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<DreamModel, List<String>, QQueryOperations> emotionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emotions');
    });
  }

  QueryBuilder<DreamModel, bool, QQueryOperations> nightmareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nightmare');
    });
  }

  QueryBuilder<DreamModel, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<DreamModel, bool, QQueryOperations> recurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurrent');
    });
  }

  QueryBuilder<DreamModel, bool, QQueryOperations> staredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stared');
    });
  }

  QueryBuilder<DreamModel, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<DreamModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
