// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodoThingTable extends TodoThing
    with TableInfo<$TodoThingTable, TodoThingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoThingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
      'detail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deadlineTimeMeta =
      const VerificationMeta('deadlineTime');
  @override
  late final GeneratedColumn<DateTime> deadlineTime = GeneratedColumn<DateTime>(
      'deadline_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updateTimeMeta =
      const VerificationMeta('updateTime');
  @override
  late final GeneratedColumn<DateTime> updateTime = GeneratedColumn<DateTime>(
      'update_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        detail,
        status,
        categoryId,
        createTime,
        deadlineTime,
        updateTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_thing';
  @override
  VerificationContext validateIntegrity(Insertable<TodoThingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('deadline_time')) {
      context.handle(
          _deadlineTimeMeta,
          deadlineTime.isAcceptableOrUnknown(
              data['deadline_time']!, _deadlineTimeMeta));
    }
    if (data.containsKey('update_time')) {
      context.handle(
          _updateTimeMeta,
          updateTime.isAcceptableOrUnknown(
              data['update_time']!, _updateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoThingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoThingData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      detail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
      deadlineTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline_time']),
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_time'])!,
    );
  }

  @override
  $TodoThingTable createAlias(String alias) {
    return $TodoThingTable(attachedDatabase, alias);
  }
}

class TodoThingData extends DataClass implements Insertable<TodoThingData> {
  final int id;
  final String title;
  final String? detail;
  final int status;
  final int? categoryId;
  final DateTime createTime;
  final DateTime? deadlineTime;
  final DateTime updateTime;
  const TodoThingData(
      {required this.id,
      required this.title,
      this.detail,
      required this.status,
      this.categoryId,
      required this.createTime,
      this.deadlineTime,
      required this.updateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['create_time'] = Variable<DateTime>(createTime);
    if (!nullToAbsent || deadlineTime != null) {
      map['deadline_time'] = Variable<DateTime>(deadlineTime);
    }
    map['update_time'] = Variable<DateTime>(updateTime);
    return map;
  }

  TodoThingCompanion toCompanion(bool nullToAbsent) {
    return TodoThingCompanion(
      id: Value(id),
      title: Value(title),
      detail:
          detail == null && nullToAbsent ? const Value.absent() : Value(detail),
      status: Value(status),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      createTime: Value(createTime),
      deadlineTime: deadlineTime == null && nullToAbsent
          ? const Value.absent()
          : Value(deadlineTime),
      updateTime: Value(updateTime),
    );
  }

  factory TodoThingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoThingData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String?>(json['detail']),
      status: serializer.fromJson<int>(json['status']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      deadlineTime: serializer.fromJson<DateTime?>(json['deadlineTime']),
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String?>(detail),
      'status': serializer.toJson<int>(status),
      'categoryId': serializer.toJson<int?>(categoryId),
      'createTime': serializer.toJson<DateTime>(createTime),
      'deadlineTime': serializer.toJson<DateTime?>(deadlineTime),
      'updateTime': serializer.toJson<DateTime>(updateTime),
    };
  }

  TodoThingData copyWith(
          {int? id,
          String? title,
          Value<String?> detail = const Value.absent(),
          int? status,
          Value<int?> categoryId = const Value.absent(),
          DateTime? createTime,
          Value<DateTime?> deadlineTime = const Value.absent(),
          DateTime? updateTime}) =>
      TodoThingData(
        id: id ?? this.id,
        title: title ?? this.title,
        detail: detail.present ? detail.value : this.detail,
        status: status ?? this.status,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        createTime: createTime ?? this.createTime,
        deadlineTime:
            deadlineTime.present ? deadlineTime.value : this.deadlineTime,
        updateTime: updateTime ?? this.updateTime,
      );
  TodoThingData copyWithCompanion(TodoThingCompanion data) {
    return TodoThingData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      detail: data.detail.present ? data.detail.value : this.detail,
      status: data.status.present ? data.status.value : this.status,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      deadlineTime: data.deadlineTime.present
          ? data.deadlineTime.value
          : this.deadlineTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoThingData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('status: $status, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('deadlineTime: $deadlineTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, detail, status, categoryId,
      createTime, deadlineTime, updateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoThingData &&
          other.id == this.id &&
          other.title == this.title &&
          other.detail == this.detail &&
          other.status == this.status &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.deadlineTime == this.deadlineTime &&
          other.updateTime == this.updateTime);
}

class TodoThingCompanion extends UpdateCompanion<TodoThingData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> detail;
  final Value<int> status;
  final Value<int?> categoryId;
  final Value<DateTime> createTime;
  final Value<DateTime?> deadlineTime;
  final Value<DateTime> updateTime;
  const TodoThingCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.status = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.deadlineTime = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  TodoThingCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.detail = const Value.absent(),
    required int status,
    this.categoryId = const Value.absent(),
    required DateTime createTime,
    this.deadlineTime = const Value.absent(),
    required DateTime updateTime,
  })  : title = Value(title),
        status = Value(status),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<TodoThingData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? detail,
    Expression<int>? status,
    Expression<int>? categoryId,
    Expression<DateTime>? createTime,
    Expression<DateTime>? deadlineTime,
    Expression<DateTime>? updateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (status != null) 'status': status,
      if (categoryId != null) 'category_id': categoryId,
      if (createTime != null) 'create_time': createTime,
      if (deadlineTime != null) 'deadline_time': deadlineTime,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  TodoThingCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? detail,
      Value<int>? status,
      Value<int?>? categoryId,
      Value<DateTime>? createTime,
      Value<DateTime?>? deadlineTime,
      Value<DateTime>? updateTime}) {
    return TodoThingCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      createTime: createTime ?? this.createTime,
      deadlineTime: deadlineTime ?? this.deadlineTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (deadlineTime.present) {
      map['deadline_time'] = Variable<DateTime>(deadlineTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoThingCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('status: $status, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('deadlineTime: $deadlineTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }
}

class $TodoThingProgressTable extends TodoThingProgress
    with TableInfo<$TodoThingProgressTable, TodoThingProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoThingProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _todoThingIdMeta =
      const VerificationMeta('todoThingId');
  @override
  late final GeneratedColumn<int> todoThingId = GeneratedColumn<int>(
      'todo_thing_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_finished" IN (0, 1))'));
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateTimeMeta =
      const VerificationMeta('updateTime');
  @override
  late final GeneratedColumn<DateTime> updateTime = GeneratedColumn<DateTime>(
      'update_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, todoThingId, content, isFinished, createTime, updateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_thing_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<TodoThingProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('todo_thing_id')) {
      context.handle(
          _todoThingIdMeta,
          todoThingId.isAcceptableOrUnknown(
              data['todo_thing_id']!, _todoThingIdMeta));
    } else if (isInserting) {
      context.missing(_todoThingIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    } else if (isInserting) {
      context.missing(_isFinishedMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
          _updateTimeMeta,
          updateTime.isAcceptableOrUnknown(
              data['update_time']!, _updateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoThingProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoThingProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      todoThingId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}todo_thing_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_time'])!,
    );
  }

  @override
  $TodoThingProgressTable createAlias(String alias) {
    return $TodoThingProgressTable(attachedDatabase, alias);
  }
}

class TodoThingProgressData extends DataClass
    implements Insertable<TodoThingProgressData> {
  final int id;
  final int todoThingId;
  final String content;
  final bool isFinished;
  final DateTime createTime;
  final DateTime updateTime;
  const TodoThingProgressData(
      {required this.id,
      required this.todoThingId,
      required this.content,
      required this.isFinished,
      required this.createTime,
      required this.updateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['todo_thing_id'] = Variable<int>(todoThingId);
    map['content'] = Variable<String>(content);
    map['is_finished'] = Variable<bool>(isFinished);
    map['create_time'] = Variable<DateTime>(createTime);
    map['update_time'] = Variable<DateTime>(updateTime);
    return map;
  }

  TodoThingProgressCompanion toCompanion(bool nullToAbsent) {
    return TodoThingProgressCompanion(
      id: Value(id),
      todoThingId: Value(todoThingId),
      content: Value(content),
      isFinished: Value(isFinished),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
    );
  }

  factory TodoThingProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoThingProgressData(
      id: serializer.fromJson<int>(json['id']),
      todoThingId: serializer.fromJson<int>(json['todoThingId']),
      content: serializer.fromJson<String>(json['content']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'todoThingId': serializer.toJson<int>(todoThingId),
      'content': serializer.toJson<String>(content),
      'isFinished': serializer.toJson<bool>(isFinished),
      'createTime': serializer.toJson<DateTime>(createTime),
      'updateTime': serializer.toJson<DateTime>(updateTime),
    };
  }

  TodoThingProgressData copyWith(
          {int? id,
          int? todoThingId,
          String? content,
          bool? isFinished,
          DateTime? createTime,
          DateTime? updateTime}) =>
      TodoThingProgressData(
        id: id ?? this.id,
        todoThingId: todoThingId ?? this.todoThingId,
        content: content ?? this.content,
        isFinished: isFinished ?? this.isFinished,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
      );
  TodoThingProgressData copyWithCompanion(TodoThingProgressCompanion data) {
    return TodoThingProgressData(
      id: data.id.present ? data.id.value : this.id,
      todoThingId:
          data.todoThingId.present ? data.todoThingId.value : this.todoThingId,
      content: data.content.present ? data.content.value : this.content,
      isFinished:
          data.isFinished.present ? data.isFinished.value : this.isFinished,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoThingProgressData(')
          ..write('id: $id, ')
          ..write('todoThingId: $todoThingId, ')
          ..write('content: $content, ')
          ..write('isFinished: $isFinished, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, todoThingId, content, isFinished, createTime, updateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoThingProgressData &&
          other.id == this.id &&
          other.todoThingId == this.todoThingId &&
          other.content == this.content &&
          other.isFinished == this.isFinished &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class TodoThingProgressCompanion
    extends UpdateCompanion<TodoThingProgressData> {
  final Value<int> id;
  final Value<int> todoThingId;
  final Value<String> content;
  final Value<bool> isFinished;
  final Value<DateTime> createTime;
  final Value<DateTime> updateTime;
  const TodoThingProgressCompanion({
    this.id = const Value.absent(),
    this.todoThingId = const Value.absent(),
    this.content = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  TodoThingProgressCompanion.insert({
    this.id = const Value.absent(),
    required int todoThingId,
    required String content,
    required bool isFinished,
    required DateTime createTime,
    required DateTime updateTime,
  })  : todoThingId = Value(todoThingId),
        content = Value(content),
        isFinished = Value(isFinished),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<TodoThingProgressData> custom({
    Expression<int>? id,
    Expression<int>? todoThingId,
    Expression<String>? content,
    Expression<bool>? isFinished,
    Expression<DateTime>? createTime,
    Expression<DateTime>? updateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todoThingId != null) 'todo_thing_id': todoThingId,
      if (content != null) 'content': content,
      if (isFinished != null) 'is_finished': isFinished,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  TodoThingProgressCompanion copyWith(
      {Value<int>? id,
      Value<int>? todoThingId,
      Value<String>? content,
      Value<bool>? isFinished,
      Value<DateTime>? createTime,
      Value<DateTime>? updateTime}) {
    return TodoThingProgressCompanion(
      id: id ?? this.id,
      todoThingId: todoThingId ?? this.todoThingId,
      content: content ?? this.content,
      isFinished: isFinished ?? this.isFinished,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (todoThingId.present) {
      map['todo_thing_id'] = Variable<int>(todoThingId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoThingProgressCompanion(')
          ..write('id: $id, ')
          ..write('todoThingId: $todoThingId, ')
          ..write('content: $content, ')
          ..write('isFinished: $isFinished, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }
}

class $CategoryTable extends my_category.Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentCategoryIdMeta =
      const VerificationMeta('parentCategoryId');
  @override
  late final GeneratedColumn<String> parentCategoryId = GeneratedColumn<String>(
      'parent_category_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateTimeMeta =
      const VerificationMeta('updateTime');
  @override
  late final GeneratedColumn<DateTime> updateTime = GeneratedColumn<DateTime>(
      'update_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, parentCategoryId, createTime, updateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_category_id')) {
      context.handle(
          _parentCategoryIdMeta,
          parentCategoryId.isAcceptableOrUnknown(
              data['parent_category_id']!, _parentCategoryIdMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
          _updateTimeMeta,
          updateTime.isAcceptableOrUnknown(
              data['update_time']!, _updateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      parentCategoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}parent_category_id']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_time'])!,
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class CategoryData extends DataClass implements Insertable<CategoryData> {
  final int id;
  final String name;
  final String? parentCategoryId;
  final DateTime createTime;
  final DateTime updateTime;
  const CategoryData(
      {required this.id,
      required this.name,
      this.parentCategoryId,
      required this.createTime,
      required this.updateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentCategoryId != null) {
      map['parent_category_id'] = Variable<String>(parentCategoryId);
    }
    map['create_time'] = Variable<DateTime>(createTime);
    map['update_time'] = Variable<DateTime>(updateTime);
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      name: Value(name),
      parentCategoryId: parentCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCategoryId),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentCategoryId: serializer.fromJson<String?>(json['parentCategoryId']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'parentCategoryId': serializer.toJson<String?>(parentCategoryId),
      'createTime': serializer.toJson<DateTime>(createTime),
      'updateTime': serializer.toJson<DateTime>(updateTime),
    };
  }

  CategoryData copyWith(
          {int? id,
          String? name,
          Value<String?> parentCategoryId = const Value.absent(),
          DateTime? createTime,
          DateTime? updateTime}) =>
      CategoryData(
        id: id ?? this.id,
        name: name ?? this.name,
        parentCategoryId: parentCategoryId.present
            ? parentCategoryId.value
            : this.parentCategoryId,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
      );
  CategoryData copyWithCompanion(CategoryCompanion data) {
    return CategoryData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      parentCategoryId: data.parentCategoryId.present
          ? data.parentCategoryId.value
          : this.parentCategoryId,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, parentCategoryId, createTime, updateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentCategoryId == this.parentCategoryId &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> parentCategoryId;
  final Value<DateTime> createTime;
  final Value<DateTime> updateTime;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentCategoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.parentCategoryId = const Value.absent(),
    required DateTime createTime,
    required DateTime updateTime,
  })  : name = Value(name),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<CategoryData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? parentCategoryId,
    Expression<DateTime>? createTime,
    Expression<DateTime>? updateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentCategoryId != null) 'parent_category_id': parentCategoryId,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  CategoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? parentCategoryId,
      Value<DateTime>? createTime,
      Value<DateTime>? updateTime}) {
    return CategoryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentCategoryId.present) {
      map['parent_category_id'] = Variable<String>(parentCategoryId.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodoThingTable todoThing = $TodoThingTable(this);
  late final $TodoThingProgressTable todoThingProgress =
      $TodoThingProgressTable(this);
  late final $CategoryTable category = $CategoryTable(this);
  late final TodoThingDao todoThingDao = TodoThingDao(this as AppDatabase);
  late final TodoThingProgressDao todoThingProgressDao =
      TodoThingProgressDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [todoThing, todoThingProgress, category];
}

typedef $$TodoThingTableCreateCompanionBuilder = TodoThingCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> detail,
  required int status,
  Value<int?> categoryId,
  required DateTime createTime,
  Value<DateTime?> deadlineTime,
  required DateTime updateTime,
});
typedef $$TodoThingTableUpdateCompanionBuilder = TodoThingCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> detail,
  Value<int> status,
  Value<int?> categoryId,
  Value<DateTime> createTime,
  Value<DateTime?> deadlineTime,
  Value<DateTime> updateTime,
});

class $$TodoThingTableFilterComposer
    extends Composer<_$AppDatabase, $TodoThingTable> {
  $$TodoThingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detail => $composableBuilder(
      column: $table.detail, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadlineTime => $composableBuilder(
      column: $table.deadlineTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));
}

class $$TodoThingTableOrderingComposer
    extends Composer<_$AppDatabase, $TodoThingTable> {
  $$TodoThingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detail => $composableBuilder(
      column: $table.detail, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadlineTime => $composableBuilder(
      column: $table.deadlineTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));
}

class $$TodoThingTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoThingTable> {
  $$TodoThingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<DateTime> get deadlineTime => $composableBuilder(
      column: $table.deadlineTime, builder: (column) => column);

  GeneratedColumn<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);
}

class $$TodoThingTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodoThingTable,
    TodoThingData,
    $$TodoThingTableFilterComposer,
    $$TodoThingTableOrderingComposer,
    $$TodoThingTableAnnotationComposer,
    $$TodoThingTableCreateCompanionBuilder,
    $$TodoThingTableUpdateCompanionBuilder,
    (
      TodoThingData,
      BaseReferences<_$AppDatabase, $TodoThingTable, TodoThingData>
    ),
    TodoThingData,
    PrefetchHooks Function()> {
  $$TodoThingTableTableManager(_$AppDatabase db, $TodoThingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoThingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoThingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoThingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> detail = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<DateTime> createTime = const Value.absent(),
            Value<DateTime?> deadlineTime = const Value.absent(),
            Value<DateTime> updateTime = const Value.absent(),
          }) =>
              TodoThingCompanion(
            id: id,
            title: title,
            detail: detail,
            status: status,
            categoryId: categoryId,
            createTime: createTime,
            deadlineTime: deadlineTime,
            updateTime: updateTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> detail = const Value.absent(),
            required int status,
            Value<int?> categoryId = const Value.absent(),
            required DateTime createTime,
            Value<DateTime?> deadlineTime = const Value.absent(),
            required DateTime updateTime,
          }) =>
              TodoThingCompanion.insert(
            id: id,
            title: title,
            detail: detail,
            status: status,
            categoryId: categoryId,
            createTime: createTime,
            deadlineTime: deadlineTime,
            updateTime: updateTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TodoThingTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TodoThingTable,
    TodoThingData,
    $$TodoThingTableFilterComposer,
    $$TodoThingTableOrderingComposer,
    $$TodoThingTableAnnotationComposer,
    $$TodoThingTableCreateCompanionBuilder,
    $$TodoThingTableUpdateCompanionBuilder,
    (
      TodoThingData,
      BaseReferences<_$AppDatabase, $TodoThingTable, TodoThingData>
    ),
    TodoThingData,
    PrefetchHooks Function()>;
typedef $$TodoThingProgressTableCreateCompanionBuilder
    = TodoThingProgressCompanion Function({
  Value<int> id,
  required int todoThingId,
  required String content,
  required bool isFinished,
  required DateTime createTime,
  required DateTime updateTime,
});
typedef $$TodoThingProgressTableUpdateCompanionBuilder
    = TodoThingProgressCompanion Function({
  Value<int> id,
  Value<int> todoThingId,
  Value<String> content,
  Value<bool> isFinished,
  Value<DateTime> createTime,
  Value<DateTime> updateTime,
});

class $$TodoThingProgressTableFilterComposer
    extends Composer<_$AppDatabase, $TodoThingProgressTable> {
  $$TodoThingProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get todoThingId => $composableBuilder(
      column: $table.todoThingId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));
}

class $$TodoThingProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $TodoThingProgressTable> {
  $$TodoThingProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get todoThingId => $composableBuilder(
      column: $table.todoThingId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));
}

class $$TodoThingProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoThingProgressTable> {
  $$TodoThingProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get todoThingId => $composableBuilder(
      column: $table.todoThingId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => column);

  GeneratedColumn<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);
}

class $$TodoThingProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodoThingProgressTable,
    TodoThingProgressData,
    $$TodoThingProgressTableFilterComposer,
    $$TodoThingProgressTableOrderingComposer,
    $$TodoThingProgressTableAnnotationComposer,
    $$TodoThingProgressTableCreateCompanionBuilder,
    $$TodoThingProgressTableUpdateCompanionBuilder,
    (
      TodoThingProgressData,
      BaseReferences<_$AppDatabase, $TodoThingProgressTable,
          TodoThingProgressData>
    ),
    TodoThingProgressData,
    PrefetchHooks Function()> {
  $$TodoThingProgressTableTableManager(
      _$AppDatabase db, $TodoThingProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoThingProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoThingProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoThingProgressTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> todoThingId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createTime = const Value.absent(),
            Value<DateTime> updateTime = const Value.absent(),
          }) =>
              TodoThingProgressCompanion(
            id: id,
            todoThingId: todoThingId,
            content: content,
            isFinished: isFinished,
            createTime: createTime,
            updateTime: updateTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int todoThingId,
            required String content,
            required bool isFinished,
            required DateTime createTime,
            required DateTime updateTime,
          }) =>
              TodoThingProgressCompanion.insert(
            id: id,
            todoThingId: todoThingId,
            content: content,
            isFinished: isFinished,
            createTime: createTime,
            updateTime: updateTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TodoThingProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TodoThingProgressTable,
    TodoThingProgressData,
    $$TodoThingProgressTableFilterComposer,
    $$TodoThingProgressTableOrderingComposer,
    $$TodoThingProgressTableAnnotationComposer,
    $$TodoThingProgressTableCreateCompanionBuilder,
    $$TodoThingProgressTableUpdateCompanionBuilder,
    (
      TodoThingProgressData,
      BaseReferences<_$AppDatabase, $TodoThingProgressTable,
          TodoThingProgressData>
    ),
    TodoThingProgressData,
    PrefetchHooks Function()>;
typedef $$CategoryTableCreateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> parentCategoryId,
  required DateTime createTime,
  required DateTime updateTime,
});
typedef $$CategoryTableUpdateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> parentCategoryId,
  Value<DateTime> createTime,
  Value<DateTime> updateTime,
});

class $$CategoryTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentCategoryId => $composableBuilder(
      column: $table.parentCategoryId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));
}

class $$CategoryTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentCategoryId => $composableBuilder(
      column: $table.parentCategoryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));
}

class $$CategoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get parentCategoryId => $composableBuilder(
      column: $table.parentCategoryId, builder: (column) => column);

  GeneratedColumn<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);
}

class $$CategoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryTable,
    CategoryData,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (CategoryData, BaseReferences<_$AppDatabase, $CategoryTable, CategoryData>),
    CategoryData,
    PrefetchHooks Function()> {
  $$CategoryTableTableManager(_$AppDatabase db, $CategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> parentCategoryId = const Value.absent(),
            Value<DateTime> createTime = const Value.absent(),
            Value<DateTime> updateTime = const Value.absent(),
          }) =>
              CategoryCompanion(
            id: id,
            name: name,
            parentCategoryId: parentCategoryId,
            createTime: createTime,
            updateTime: updateTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> parentCategoryId = const Value.absent(),
            required DateTime createTime,
            required DateTime updateTime,
          }) =>
              CategoryCompanion.insert(
            id: id,
            name: name,
            parentCategoryId: parentCategoryId,
            createTime: createTime,
            updateTime: updateTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryTable,
    CategoryData,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (CategoryData, BaseReferences<_$AppDatabase, $CategoryTable, CategoryData>),
    CategoryData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodoThingTableTableManager get todoThing =>
      $$TodoThingTableTableManager(_db, _db.todoThing);
  $$TodoThingProgressTableTableManager get todoThingProgress =>
      $$TodoThingProgressTableTableManager(_db, _db.todoThingProgress);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db, _db.category);
}
