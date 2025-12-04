// GENERATED CODE - MANUALLY CREATED
// This file was manually created due to dependency conflicts between
// isar_generator and freezed/riverpod_generator which prevent automatic code generation.
//
// DO NOT MODIFY THIS FILE MANUALLY except to update when schema changes.
//
// This schema is based on Isar 3.1.0+1 format and matches the
// ChoreCollection class definition in chore_collection.dart

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'chore_collection.dart';

/// The CollectionSchema for ChoreCollection.
const ChoreCollectionSchema = CollectionSchema(
  name: r'ChoreCollection',
  id: -7307467360364828809,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'isCompleted': PropertySchema(
      id: 4,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
  },
  estimateSize: _choreCollectionEstimateSize,
  serialize: _choreCollectionSerialize,
  deserialize: _choreCollectionDeserialize,
  deserializeProp: _choreCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'createdAt': IndexSchema(
      id: 8575489064545956488,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'isCompleted': IndexSchema(
      id: 6559608246648734940,
      name: r'isCompleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isCompleted',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _choreCollectionGetId,
  getLinks: _choreCollectionGetLinks,
  attach: _choreCollectionAttach,
  version: '3.1.0+1',
);

int _choreCollectionEstimateSize(
  ChoreCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _choreCollectionSerialize(
  ChoreCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.id);
  writer.writeBool(offsets[4], object.isCompleted);
  writer.writeString(offsets[5], object.title);
}

ChoreCollection _choreCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChoreCollection.fromChore(
    Chore(
      id: reader.readString(offsets[3]),
      title: reader.readString(offsets[5]),
      createdAt: reader.readDateTime(offsets[1]),
      description: reader.readStringOrNull(offsets[2]),
      completedAt: reader.readDateTimeOrNull(offsets[0]),
      isCompleted: reader.readBool(offsets[4]),
    ),
  );
  object.isarId = id;
  return object;
}

P _choreCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _choreCollectionGetId(ChoreCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _choreCollectionGetLinks(ChoreCollection object) {
  return [];
}

void _choreCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  ChoreCollection object,
) {
  object.isarId = id;
}

extension GetChoreCollectionCollection on Isar {
  IsarCollection<ChoreCollection> get choreCollections => this.collection();
}
