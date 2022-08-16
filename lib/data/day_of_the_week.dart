final weekDays = [
  DayOfTheWeek(index: DateTime.monday, name: "月"),
  DayOfTheWeek(index: DateTime.tuesday, name: "火"),
  DayOfTheWeek(index: DateTime.wednesday, name: "水"),
  DayOfTheWeek(index: DateTime.thursday, name: "木"),
  DayOfTheWeek(index: DateTime.friday, name: "金"),
  DayOfTheWeek(index: DateTime.saturday, name: "土"),
  DayOfTheWeek(index: DateTime.sunday, name: "日"),
];


class DayOfTheWeek {
  final int index;
  final String name;

//<editor-fold desc="Data Methods">

  const DayOfTheWeek({
    required this.index,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayOfTheWeek &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          name == other.name);

  @override
  int get hashCode => index.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'DayOfTheWeek{' + ' index: $index,' + ' name: $name,' + '}';
  }

  DayOfTheWeek copyWith({
    int? index,
    String? name,
  }) {
    return DayOfTheWeek(
      index: index ?? this.index,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': this.index,
      'name': this.name,
    };
  }

  factory DayOfTheWeek.fromMap(Map<String, dynamic> map) {
    return DayOfTheWeek(
      index: map['index'] as int,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}