import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'alarm_data.g.dart';

enum AlarmMode { ONCE, EVERY } //１回のみ（この場合は曜日は押せない）・毎週（曜日が押せる）

/*
* AlarmDataをDBに格納する必要がある（Alarmを設定しているけど一時的に無効化している場合は
* awesome_notifications（SharedPreferences）には保存できないようなので
* => SQLiteはListが格納できないので曜日ごとにフィールドをもたせる必要あり
*   https://drift.simonbinder.eu/docs/getting-started/advanced_dart_tables/#supported-column-types
* */
class Alarms extends Table {
  TextColumn get groupKey => text()();

  //DriftでDateTime型の保存はUnixのTimeStamp型と文字列型（IOS8601String）があり、デフォルトではTimeStamp型らしい
  //https://drift.simonbinder.eu/docs/getting-started/advanced_dart_tables/#datetime-options
  // => ただしTimeStamp型はUTCでは格納できないようなので、UTCで格納したい場合は文字列型にする必要あり
  // => buildオプションで「store_date_time_values_as_text」をtrueに設定する必要あり
  //  https://drift.simonbinder.eu/docs/advanced-features/builder_options/#available-options
  DateTimeColumn get time => dateTime()();

  BoolColumn get isEnabled => boolean()();

  //https://drift.simonbinder.eu/docs/advanced-features/type_converters/#implicit-enum-converters
  IntColumn get mode => intEnum<AlarmMode>()();

  //SQLiteはListが格納できないので曜日ごとにフィールドをもたせる必要あり
  //https://drift.simonbinder.eu/docs/getting-started/advanced_dart_tables/#supported-column-types
  BoolColumn get isMondayEnabled => boolean()();

  BoolColumn get isTuesdayEnabled => boolean()();

  BoolColumn get isWednesdayEnabled => boolean()();

  BoolColumn get isThursdayEnabled => boolean()();

  BoolColumn get isFridayEnabled => boolean()();

  BoolColumn get isSaturdayEnabled => boolean()();

  BoolColumn get isSundayEnabled => boolean()();

  @override
  Set<Column> get primaryKey => {groupKey};
}

@DriftDatabase(tables: [Alarms])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'alarm');
  }

  @override
  int get schemaVersion => 1;

  Future<void> insertAlarm(Alarm alarm) => into(alarms).insert(alarm);

  Future<List<Alarm>> get allAlarms => managers.alarms.get();

  Future<void> deleteAlarm(String groupKey) =>
      managers.alarms.filter((f) => f.groupKey(groupKey)).delete();

  Future<void> updateAlarm(Alarm alarm) => managers.alarms.replace(alarm);
}
