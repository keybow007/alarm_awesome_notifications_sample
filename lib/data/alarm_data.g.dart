// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_data.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Alarm extends DataClass implements Insertable<Alarm> {
  final String groupKey;
  final DateTime time;
  final bool isEnabled;
  final AlarmMode mode;
  final bool isMondayEnabled;
  final bool isTuesdayEnabled;
  final bool isWednesdayEnabled;
  final bool isThursdayEnabled;
  final bool isFridayEnabled;
  final bool isSaturdayEnabled;
  final bool isSundayEnabled;
  Alarm(
      {required this.groupKey,
      required this.time,
      required this.isEnabled,
      required this.mode,
      required this.isMondayEnabled,
      required this.isTuesdayEnabled,
      required this.isWednesdayEnabled,
      required this.isThursdayEnabled,
      required this.isFridayEnabled,
      required this.isSaturdayEnabled,
      required this.isSundayEnabled});
  factory Alarm.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Alarm(
      groupKey: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}group_key'])!,
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
      isEnabled: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_enabled'])!,
      mode: $AlarmsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mode']))!,
      isMondayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_monday_enabled'])!,
      isTuesdayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_tuesday_enabled'])!,
      isWednesdayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_wednesday_enabled'])!,
      isThursdayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_thursday_enabled'])!,
      isFridayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_friday_enabled'])!,
      isSaturdayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_saturday_enabled'])!,
      isSundayEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_sunday_enabled'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_key'] = Variable<String>(groupKey);
    map['time'] = Variable<DateTime>(time);
    map['is_enabled'] = Variable<bool>(isEnabled);
    {
      final converter = $AlarmsTable.$converter0;
      map['mode'] = Variable<int>(converter.mapToSql(mode)!);
    }
    map['is_monday_enabled'] = Variable<bool>(isMondayEnabled);
    map['is_tuesday_enabled'] = Variable<bool>(isTuesdayEnabled);
    map['is_wednesday_enabled'] = Variable<bool>(isWednesdayEnabled);
    map['is_thursday_enabled'] = Variable<bool>(isThursdayEnabled);
    map['is_friday_enabled'] = Variable<bool>(isFridayEnabled);
    map['is_saturday_enabled'] = Variable<bool>(isSaturdayEnabled);
    map['is_sunday_enabled'] = Variable<bool>(isSundayEnabled);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      groupKey: Value(groupKey),
      time: Value(time),
      isEnabled: Value(isEnabled),
      mode: Value(mode),
      isMondayEnabled: Value(isMondayEnabled),
      isTuesdayEnabled: Value(isTuesdayEnabled),
      isWednesdayEnabled: Value(isWednesdayEnabled),
      isThursdayEnabled: Value(isThursdayEnabled),
      isFridayEnabled: Value(isFridayEnabled),
      isSaturdayEnabled: Value(isSaturdayEnabled),
      isSundayEnabled: Value(isSundayEnabled),
    );
  }

  factory Alarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      groupKey: serializer.fromJson<String>(json['groupKey']),
      time: serializer.fromJson<DateTime>(json['time']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      mode: serializer.fromJson<AlarmMode>(json['mode']),
      isMondayEnabled: serializer.fromJson<bool>(json['isMondayEnabled']),
      isTuesdayEnabled: serializer.fromJson<bool>(json['isTuesdayEnabled']),
      isWednesdayEnabled: serializer.fromJson<bool>(json['isWednesdayEnabled']),
      isThursdayEnabled: serializer.fromJson<bool>(json['isThursdayEnabled']),
      isFridayEnabled: serializer.fromJson<bool>(json['isFridayEnabled']),
      isSaturdayEnabled: serializer.fromJson<bool>(json['isSaturdayEnabled']),
      isSundayEnabled: serializer.fromJson<bool>(json['isSundayEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupKey': serializer.toJson<String>(groupKey),
      'time': serializer.toJson<DateTime>(time),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'mode': serializer.toJson<AlarmMode>(mode),
      'isMondayEnabled': serializer.toJson<bool>(isMondayEnabled),
      'isTuesdayEnabled': serializer.toJson<bool>(isTuesdayEnabled),
      'isWednesdayEnabled': serializer.toJson<bool>(isWednesdayEnabled),
      'isThursdayEnabled': serializer.toJson<bool>(isThursdayEnabled),
      'isFridayEnabled': serializer.toJson<bool>(isFridayEnabled),
      'isSaturdayEnabled': serializer.toJson<bool>(isSaturdayEnabled),
      'isSundayEnabled': serializer.toJson<bool>(isSundayEnabled),
    };
  }

  Alarm copyWith(
          {String? groupKey,
          DateTime? time,
          bool? isEnabled,
          AlarmMode? mode,
          bool? isMondayEnabled,
          bool? isTuesdayEnabled,
          bool? isWednesdayEnabled,
          bool? isThursdayEnabled,
          bool? isFridayEnabled,
          bool? isSaturdayEnabled,
          bool? isSundayEnabled}) =>
      Alarm(
        groupKey: groupKey ?? this.groupKey,
        time: time ?? this.time,
        isEnabled: isEnabled ?? this.isEnabled,
        mode: mode ?? this.mode,
        isMondayEnabled: isMondayEnabled ?? this.isMondayEnabled,
        isTuesdayEnabled: isTuesdayEnabled ?? this.isTuesdayEnabled,
        isWednesdayEnabled: isWednesdayEnabled ?? this.isWednesdayEnabled,
        isThursdayEnabled: isThursdayEnabled ?? this.isThursdayEnabled,
        isFridayEnabled: isFridayEnabled ?? this.isFridayEnabled,
        isSaturdayEnabled: isSaturdayEnabled ?? this.isSaturdayEnabled,
        isSundayEnabled: isSundayEnabled ?? this.isSundayEnabled,
      );
  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('groupKey: $groupKey, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('mode: $mode, ')
          ..write('isMondayEnabled: $isMondayEnabled, ')
          ..write('isTuesdayEnabled: $isTuesdayEnabled, ')
          ..write('isWednesdayEnabled: $isWednesdayEnabled, ')
          ..write('isThursdayEnabled: $isThursdayEnabled, ')
          ..write('isFridayEnabled: $isFridayEnabled, ')
          ..write('isSaturdayEnabled: $isSaturdayEnabled, ')
          ..write('isSundayEnabled: $isSundayEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      groupKey,
      time,
      isEnabled,
      mode,
      isMondayEnabled,
      isTuesdayEnabled,
      isWednesdayEnabled,
      isThursdayEnabled,
      isFridayEnabled,
      isSaturdayEnabled,
      isSundayEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.groupKey == this.groupKey &&
          other.time == this.time &&
          other.isEnabled == this.isEnabled &&
          other.mode == this.mode &&
          other.isMondayEnabled == this.isMondayEnabled &&
          other.isTuesdayEnabled == this.isTuesdayEnabled &&
          other.isWednesdayEnabled == this.isWednesdayEnabled &&
          other.isThursdayEnabled == this.isThursdayEnabled &&
          other.isFridayEnabled == this.isFridayEnabled &&
          other.isSaturdayEnabled == this.isSaturdayEnabled &&
          other.isSundayEnabled == this.isSundayEnabled);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<String> groupKey;
  final Value<DateTime> time;
  final Value<bool> isEnabled;
  final Value<AlarmMode> mode;
  final Value<bool> isMondayEnabled;
  final Value<bool> isTuesdayEnabled;
  final Value<bool> isWednesdayEnabled;
  final Value<bool> isThursdayEnabled;
  final Value<bool> isFridayEnabled;
  final Value<bool> isSaturdayEnabled;
  final Value<bool> isSundayEnabled;
  const AlarmsCompanion({
    this.groupKey = const Value.absent(),
    this.time = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.mode = const Value.absent(),
    this.isMondayEnabled = const Value.absent(),
    this.isTuesdayEnabled = const Value.absent(),
    this.isWednesdayEnabled = const Value.absent(),
    this.isThursdayEnabled = const Value.absent(),
    this.isFridayEnabled = const Value.absent(),
    this.isSaturdayEnabled = const Value.absent(),
    this.isSundayEnabled = const Value.absent(),
  });
  AlarmsCompanion.insert({
    required String groupKey,
    required DateTime time,
    required bool isEnabled,
    required AlarmMode mode,
    required bool isMondayEnabled,
    required bool isTuesdayEnabled,
    required bool isWednesdayEnabled,
    required bool isThursdayEnabled,
    required bool isFridayEnabled,
    required bool isSaturdayEnabled,
    required bool isSundayEnabled,
  })  : groupKey = Value(groupKey),
        time = Value(time),
        isEnabled = Value(isEnabled),
        mode = Value(mode),
        isMondayEnabled = Value(isMondayEnabled),
        isTuesdayEnabled = Value(isTuesdayEnabled),
        isWednesdayEnabled = Value(isWednesdayEnabled),
        isThursdayEnabled = Value(isThursdayEnabled),
        isFridayEnabled = Value(isFridayEnabled),
        isSaturdayEnabled = Value(isSaturdayEnabled),
        isSundayEnabled = Value(isSundayEnabled);
  static Insertable<Alarm> custom({
    Expression<String>? groupKey,
    Expression<DateTime>? time,
    Expression<bool>? isEnabled,
    Expression<AlarmMode>? mode,
    Expression<bool>? isMondayEnabled,
    Expression<bool>? isTuesdayEnabled,
    Expression<bool>? isWednesdayEnabled,
    Expression<bool>? isThursdayEnabled,
    Expression<bool>? isFridayEnabled,
    Expression<bool>? isSaturdayEnabled,
    Expression<bool>? isSundayEnabled,
  }) {
    return RawValuesInsertable({
      if (groupKey != null) 'group_key': groupKey,
      if (time != null) 'time': time,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (mode != null) 'mode': mode,
      if (isMondayEnabled != null) 'is_monday_enabled': isMondayEnabled,
      if (isTuesdayEnabled != null) 'is_tuesday_enabled': isTuesdayEnabled,
      if (isWednesdayEnabled != null)
        'is_wednesday_enabled': isWednesdayEnabled,
      if (isThursdayEnabled != null) 'is_thursday_enabled': isThursdayEnabled,
      if (isFridayEnabled != null) 'is_friday_enabled': isFridayEnabled,
      if (isSaturdayEnabled != null) 'is_saturday_enabled': isSaturdayEnabled,
      if (isSundayEnabled != null) 'is_sunday_enabled': isSundayEnabled,
    });
  }

  AlarmsCompanion copyWith(
      {Value<String>? groupKey,
      Value<DateTime>? time,
      Value<bool>? isEnabled,
      Value<AlarmMode>? mode,
      Value<bool>? isMondayEnabled,
      Value<bool>? isTuesdayEnabled,
      Value<bool>? isWednesdayEnabled,
      Value<bool>? isThursdayEnabled,
      Value<bool>? isFridayEnabled,
      Value<bool>? isSaturdayEnabled,
      Value<bool>? isSundayEnabled}) {
    return AlarmsCompanion(
      groupKey: groupKey ?? this.groupKey,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
      mode: mode ?? this.mode,
      isMondayEnabled: isMondayEnabled ?? this.isMondayEnabled,
      isTuesdayEnabled: isTuesdayEnabled ?? this.isTuesdayEnabled,
      isWednesdayEnabled: isWednesdayEnabled ?? this.isWednesdayEnabled,
      isThursdayEnabled: isThursdayEnabled ?? this.isThursdayEnabled,
      isFridayEnabled: isFridayEnabled ?? this.isFridayEnabled,
      isSaturdayEnabled: isSaturdayEnabled ?? this.isSaturdayEnabled,
      isSundayEnabled: isSundayEnabled ?? this.isSundayEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupKey.present) {
      map['group_key'] = Variable<String>(groupKey.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (mode.present) {
      final converter = $AlarmsTable.$converter0;
      map['mode'] = Variable<int>(converter.mapToSql(mode.value)!);
    }
    if (isMondayEnabled.present) {
      map['is_monday_enabled'] = Variable<bool>(isMondayEnabled.value);
    }
    if (isTuesdayEnabled.present) {
      map['is_tuesday_enabled'] = Variable<bool>(isTuesdayEnabled.value);
    }
    if (isWednesdayEnabled.present) {
      map['is_wednesday_enabled'] = Variable<bool>(isWednesdayEnabled.value);
    }
    if (isThursdayEnabled.present) {
      map['is_thursday_enabled'] = Variable<bool>(isThursdayEnabled.value);
    }
    if (isFridayEnabled.present) {
      map['is_friday_enabled'] = Variable<bool>(isFridayEnabled.value);
    }
    if (isSaturdayEnabled.present) {
      map['is_saturday_enabled'] = Variable<bool>(isSaturdayEnabled.value);
    }
    if (isSundayEnabled.present) {
      map['is_sunday_enabled'] = Variable<bool>(isSundayEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('groupKey: $groupKey, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('mode: $mode, ')
          ..write('isMondayEnabled: $isMondayEnabled, ')
          ..write('isTuesdayEnabled: $isTuesdayEnabled, ')
          ..write('isWednesdayEnabled: $isWednesdayEnabled, ')
          ..write('isThursdayEnabled: $isThursdayEnabled, ')
          ..write('isFridayEnabled: $isFridayEnabled, ')
          ..write('isSaturdayEnabled: $isSaturdayEnabled, ')
          ..write('isSundayEnabled: $isSundayEnabled')
          ..write(')'))
        .toString();
  }
}

class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _groupKeyMeta = const VerificationMeta('groupKey');
  @override
  late final GeneratedColumn<String?> groupKey = GeneratedColumn<String?>(
      'group_key', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isEnabledMeta = const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool?> isEnabled = GeneratedColumn<bool?>(
      'is_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_enabled IN (0, 1))');
  final VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumnWithTypeConverter<AlarmMode, int?> mode =
      GeneratedColumn<int?>('mode', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<AlarmMode>($AlarmsTable.$converter0);
  final VerificationMeta _isMondayEnabledMeta =
      const VerificationMeta('isMondayEnabled');
  @override
  late final GeneratedColumn<bool?> isMondayEnabled = GeneratedColumn<bool?>(
      'is_monday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_monday_enabled IN (0, 1))');
  final VerificationMeta _isTuesdayEnabledMeta =
      const VerificationMeta('isTuesdayEnabled');
  @override
  late final GeneratedColumn<bool?> isTuesdayEnabled = GeneratedColumn<bool?>(
      'is_tuesday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_tuesday_enabled IN (0, 1))');
  final VerificationMeta _isWednesdayEnabledMeta =
      const VerificationMeta('isWednesdayEnabled');
  @override
  late final GeneratedColumn<bool?> isWednesdayEnabled = GeneratedColumn<bool?>(
      'is_wednesday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_wednesday_enabled IN (0, 1))');
  final VerificationMeta _isThursdayEnabledMeta =
      const VerificationMeta('isThursdayEnabled');
  @override
  late final GeneratedColumn<bool?> isThursdayEnabled = GeneratedColumn<bool?>(
      'is_thursday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_thursday_enabled IN (0, 1))');
  final VerificationMeta _isFridayEnabledMeta =
      const VerificationMeta('isFridayEnabled');
  @override
  late final GeneratedColumn<bool?> isFridayEnabled = GeneratedColumn<bool?>(
      'is_friday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_friday_enabled IN (0, 1))');
  final VerificationMeta _isSaturdayEnabledMeta =
      const VerificationMeta('isSaturdayEnabled');
  @override
  late final GeneratedColumn<bool?> isSaturdayEnabled = GeneratedColumn<bool?>(
      'is_saturday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_saturday_enabled IN (0, 1))');
  final VerificationMeta _isSundayEnabledMeta =
      const VerificationMeta('isSundayEnabled');
  @override
  late final GeneratedColumn<bool?> isSundayEnabled = GeneratedColumn<bool?>(
      'is_sunday_enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_sunday_enabled IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        groupKey,
        time,
        isEnabled,
        mode,
        isMondayEnabled,
        isTuesdayEnabled,
        isWednesdayEnabled,
        isThursdayEnabled,
        isFridayEnabled,
        isSaturdayEnabled,
        isSundayEnabled
      ];
  @override
  String get aliasedName => _alias ?? 'alarms';
  @override
  String get actualTableName => 'alarms';
  @override
  VerificationContext validateIntegrity(Insertable<Alarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_key')) {
      context.handle(_groupKeyMeta,
          groupKey.isAcceptableOrUnknown(data['group_key']!, _groupKeyMeta));
    } else if (isInserting) {
      context.missing(_groupKeyMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    } else if (isInserting) {
      context.missing(_isEnabledMeta);
    }
    context.handle(_modeMeta, const VerificationResult.success());
    if (data.containsKey('is_monday_enabled')) {
      context.handle(
          _isMondayEnabledMeta,
          isMondayEnabled.isAcceptableOrUnknown(
              data['is_monday_enabled']!, _isMondayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isMondayEnabledMeta);
    }
    if (data.containsKey('is_tuesday_enabled')) {
      context.handle(
          _isTuesdayEnabledMeta,
          isTuesdayEnabled.isAcceptableOrUnknown(
              data['is_tuesday_enabled']!, _isTuesdayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isTuesdayEnabledMeta);
    }
    if (data.containsKey('is_wednesday_enabled')) {
      context.handle(
          _isWednesdayEnabledMeta,
          isWednesdayEnabled.isAcceptableOrUnknown(
              data['is_wednesday_enabled']!, _isWednesdayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isWednesdayEnabledMeta);
    }
    if (data.containsKey('is_thursday_enabled')) {
      context.handle(
          _isThursdayEnabledMeta,
          isThursdayEnabled.isAcceptableOrUnknown(
              data['is_thursday_enabled']!, _isThursdayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isThursdayEnabledMeta);
    }
    if (data.containsKey('is_friday_enabled')) {
      context.handle(
          _isFridayEnabledMeta,
          isFridayEnabled.isAcceptableOrUnknown(
              data['is_friday_enabled']!, _isFridayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isFridayEnabledMeta);
    }
    if (data.containsKey('is_saturday_enabled')) {
      context.handle(
          _isSaturdayEnabledMeta,
          isSaturdayEnabled.isAcceptableOrUnknown(
              data['is_saturday_enabled']!, _isSaturdayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isSaturdayEnabledMeta);
    }
    if (data.containsKey('is_sunday_enabled')) {
      context.handle(
          _isSundayEnabledMeta,
          isSundayEnabled.isAcceptableOrUnknown(
              data['is_sunday_enabled']!, _isSundayEnabledMeta));
    } else if (isInserting) {
      context.missing(_isSundayEnabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupKey};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Alarm.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }

  static TypeConverter<AlarmMode, int> $converter0 =
      const EnumIndexConverter<AlarmMode>(AlarmMode.values);
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [alarms];
}
