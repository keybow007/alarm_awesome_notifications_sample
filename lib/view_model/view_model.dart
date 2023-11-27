import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:flutter/material.dart';

import '../model/notification_manager.dart';

class ViewModel extends ChangeNotifier {
  final NotificationManager notificationManager;

  ViewModel({required this.notificationManager});

  List<Alarm> alarms = [];

  @override
  void dispose() {
    notificationManager.dispose();
    super.dispose();
  }

  void onUpdated() {
    notifyListeners();
  }

  Future<void> getAlarms() async {
    alarms = await notificationManager.getAlarms();
    notifyListeners();
  }

  Future<void> setAlarm({required Alarm alarmData, required bool isNeedDbInsert}) async {
    await notificationManager.setAlarm(alarmData: alarmData, isNeedDbInsert: isNeedDbInsert);
    await getAlarms();
  }

  void setAlarmEnabled(Alarm alarm, bool isEnabled) async {
    //DBに保存しているAlarmデータの更新
    await notificationManager.onEnableChanged(alarm, isEnabled);

    if (isEnabled) {
      //awesome_notificationsの有効化：setAlarm
      await setAlarm(alarmData: alarm, isNeedDbInsert: false);
    } else {
      //awesome_notificationsの無効化：cancelAlarm
      await cancelAlarm(alarm: alarm, isDelete: false);
    }
    notifyListeners();
  }

  Future<void> cancelAlarm(
      {required Alarm alarm, required bool isDelete}) async {
    await notificationManager.cancelAlarm(alarm.groupKey);
    if (isDelete) {
      await notificationManager.deleteAlarm(alarm.groupKey);
    }
    await getAlarms();
  }
}
