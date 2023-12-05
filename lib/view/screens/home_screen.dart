import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:alarm_local_notifications_sample/model/notification_manager.dart';
import 'package:alarm_local_notifications_sample/view/components/alarm_card.dart';
import 'package:alarm_local_notifications_sample/view/components/alarm_setting_dialog.dart';
import 'package:alarm_local_notifications_sample/view/screens/second_screen.dart';
import 'package:alarm_local_notifications_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await NotificationManager.getNotificationAction();
      if (NotificationManager.initialAction?.channelKey ==
          NotificationManager.channelKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SecondScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future(() {
      final vm = context.read<ViewModel>();
      vm.getAlarms();
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAlarmSettingDialog(context),
      ),
      body: Consumer<ViewModel>(
        builder: (context, vm, child) {
          final alarms = vm.alarms;
          if (alarms.isEmpty) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: alarms.length,
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                final alarm = alarms[index];
                return AlarmCard(
                  //Keyがないと要素削除後に再描画されてしまう
                  key: Key(alarm.groupKey),
                  alarmData: alarm,
                );
              },
            );
          }
        },
      ),
    );
  }

  _openAlarmSettingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlarmSettingDialog(
          alarmData: Alarm(
            groupKey: Uuid().v1(),
            time: DateTime.now(),
            isEnabled: true,
            mode: AlarmMode.ONCE,
            isMondayEnabled: false,
            isTuesdayEnabled: false,
            isWednesdayEnabled: false,
            isThursdayEnabled: false,
            isFridayEnabled: false,
            isSaturdayEnabled: false,
            isSundayEnabled: false,
          ),
        );
      },
    );
  }
}
