import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:alarm_local_notifications_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlarmCard extends StatefulWidget {
  final Alarm alarmData;
  AlarmCard({Key? key, required this.alarmData}) : super(key: key);

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  bool isAlarmEnabled = false;

  @override
  void initState() {
    this.isAlarmEnabled = widget.alarmData.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (isAlarmEnabled) ? 1.0 : 0.3,
      child: Card(
          color: Colors.black45,
          child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.alarmData.groupKey),
                  //TODO
                  Text(widget.alarmData.mode.toString()),
                  (widget.alarmData.mode == AlarmMode.EVERY) ? Wrap(
                    children: [
                      (widget.alarmData.isMondayEnabled) ? Text(" 月 ") : Text(" ー "),
                      (widget.alarmData.isTuesdayEnabled) ? Text(" 火 ") : Text(" ー "),
                      (widget.alarmData.isWednesdayEnabled) ? Text(" 水 ") : Text(" ー "),
                      (widget.alarmData.isThursdayEnabled) ? Text(" 木 ") : Text(" ー "),
                      (widget.alarmData.isFridayEnabled) ? Text(" 金 ") : Text(" ー "),
                      (widget.alarmData.isSaturdayEnabled) ? Text(" 土 ") : Text(" ー "),
                      (widget.alarmData.isSundayEnabled) ? Text(" 日 ") : Text(" ー "),

                    ],
                  ) : Container(),
                ],
              ),
              title: Text(
                DateFormat("H:mm").format(widget.alarmData.time).padLeft(5),
                style: TextStyle(fontSize: 32),),
              trailing: Switch(
                //有効か無効か切り替えトグル
                value: this.isAlarmEnabled,
                onChanged: (bool isEnabled) {
                  setState(() {
                    this.isAlarmEnabled = isEnabled;
                  });
                  _setAlarmEnabled(context, widget.alarmData, isEnabled);
                },
              ),
              // trailing: チェックボックス,
              //onTap: () => _goSetAlarm(alarmList[index],context, id: alarmList[index].id),
              onTap: () => _editAlarm(context, widget.alarmData),
              onLongPress: () => _deleteAlarm(context, widget.alarmData)
          )
      ),
    );
  }

  _editAlarm(BuildContext context, Alarm selectedAlarm) {
    final vm = context.read<ViewModel>();

  }

  Future<void> _deleteAlarm(BuildContext context, Alarm selectedAlarm) async {
    final vm = context.read<ViewModel>();
    await vm.cancelAlarm(alarm: selectedAlarm, isDelete: true);

  }

  _setAlarmEnabled(BuildContext context, Alarm selectedAlarm, bool isEnabled) {
    final vm = context.read<ViewModel>();
    vm.setAlarmEnabled(selectedAlarm, isEnabled);
  }
}
