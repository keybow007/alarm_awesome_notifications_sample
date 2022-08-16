import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:alarm_local_notifications_sample/data/day_of_the_week.dart';
import 'package:alarm_local_notifications_sample/view/components/am_pm_change.dart';
import 'package:alarm_local_notifications_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'digit.dart';
import 'square_button.dart';

class AlarmSettingDialog extends StatefulWidget {
  final Alarm alarmData;

  const AlarmSettingDialog({Key? key, required this.alarmData})
      : super(key: key);

  @override
  State<AlarmSettingDialog> createState() => _AlarmSettingDialogState();
}

class _AlarmSettingDialogState extends State<AlarmSettingDialog> {
  AlarmMode _alarmMode = AlarmMode.ONCE;
  List<int> _selects = [0, 0, 0];
  List<int> _weekList = [];
  bool _isPM = true;
  List<String> _times = [];

  @override
  void initState() {
    _times = DateFormat("K:mm").format(widget.alarmData.time).split(":");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: ListTile.divideTiles(
              context: context,
              color: Colors.white,
              tiles: [
                Container(
                  height: 140,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AmPmChange(
                            widget.alarmData.time.hour > 11, (v) => _isPM = v),
                        SizedBox(width: 8),
                        Digit(72, 12,
                            init: "${_times[0]}",
                            value: (v) => _selects[0] = v),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text(":",
                              style: const TextStyle(fontSize: 42.0)),
                        ),
                        Digit(42, 6,
                            init: "${_times[1].substring(0, 1)}",
                            value: (v) => _selects[1] = v),
                        SizedBox(width: 4),
                        Digit(42, 10,
                            init: "${_times[1].substring(1)}",
                            value: (v) => _selects[2] = v),
                      ],
                    ),
                  ),
                ),
                Consumer<ViewModel>(
                    builder: (context, vm, child) => ListTile(
                            title: Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            SquareButton(
                              label: "１回のみ",
                              fontSize: 24,
                              width: 108,
                              height: 42,
                              color: _alarmMode == AlarmMode.ONCE
                                  ? (Colors.orange[300] ?? Colors.orangeAccent)
                                  : Colors.white30,
                              fontColor: Colors.black,
                              onTap: () {
                                _alarmMode = AlarmMode.ONCE;
                                vm.onUpdated();
                              },
                            ),
                            SquareButton(
                              label: "毎 週",
                              fontSize: 24,
                              width: 88,
                              height: 42,
                              color: _alarmMode == AlarmMode.EVERY
                                  ? (Colors.orange[300] ?? Colors.orangeAccent)
                                  : Colors.white30,
                              fontColor: Colors.black,
                              onTap: () {
                                _alarmMode = AlarmMode.EVERY;
                                vm.onUpdated();
                              },
                            ),
                          ],
                        ))),
                Consumer<ViewModel>(
                  builder: (context, vm, child) => ListTile(
                    leading: const Text("曜日"),
                    title: Wrap(
                      spacing: 1,
                      children: List.generate(8, (i) {
                        return SquareButton(
                            label: i < 7
                                ? weekDays[i].name
                                //? weekName[i]
                                // : "祝日除外",
                                : "毎 日",
                            width: i < 7 ? 42 : 88,
                            height: 42,
                            fontSize: 24,
                            color: _weekList.contains(i + 1)
                                ? (Colors.orange[300] ?? Colors.orangeAccent)
                                : Colors.white30,
                            fontColor: i == 6
                                ? Colors.red
                                : i == 5
                                    ? Colors.blue
                                    : Colors.black,
                            onTap: _alarmMode == AlarmMode.ONCE
                                ? null
                                : () {
                                    if (i < 7) {
                                      if (_weekList.contains(i + 1)) {
                                        _weekList.remove(i + 1);
                                      } else {
                                        _weekList.add(i + 1);
                                      }
                                      vm.onUpdated();
                                    }
                                  });
                      }),
                    ),
                  ),
                ),
              ],
            ).toList(),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Text("キャンセル"),
          ),
        ),
        InkWell(
          onTap: () {
            setAlarm(context);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Text("アラームをセット"),
          ),
        )
      ],
    );
  }

  setAlarm(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    if (_weekList.length > 1) {
      _weekList.sort((a, b) => a.compareTo(b));
    }

    viewModel.setAlarm(
      alarmData: Alarm(
        groupKey: Uuid().v1(),
        time: DateFormat("H:mm").parseStrict(
            "${_selects[0] + (_isPM ? 12 : 0)}:${_selects[1]}${_selects[2]}"),
        mode: _alarmMode,
        isEnabled: true,
        isMondayEnabled: _weekList.contains(DateTime.monday),
        isTuesdayEnabled: _weekList.contains(DateTime.tuesday),
        isWednesdayEnabled: _weekList.contains(DateTime.wednesday),
        isThursdayEnabled: _weekList.contains(DateTime.thursday),
        isFridayEnabled: _weekList.contains(DateTime.friday),
        isSaturdayEnabled: _weekList.contains(DateTime.saturday),
        isSundayEnabled: _weekList.contains(DateTime.sunday),
      ),
      isNeedDbInsert: true,
    );
    Navigator.pop(context);
  }
}
