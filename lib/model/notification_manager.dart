import 'dart:async';

import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:alarm_local_notifications_sample/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'shared_prefs_manager.dart';

class NotificationManager {
  final SharedPrefsManager sharedPrefsManager;
  final MyDatabase localDbManager;

  //通知が作成されたことを検知
  StreamSubscription<ReceivedNotification>? createdStreamSubscription;

  //通知が表示されたことを検知
  StreamSubscription<ReceivedNotification>? displayedStreamSubscription;

  //通知を開いたことを検知
  StreamSubscription<ReceivedAction>? actionStreamSubscription;

  NotificationManager(
      {required this.sharedPrefsManager, required this.localDbManager}) {
    init();
  }

  static ReceivedAction? initialAction;
  static String channelKey = "alarm";

  static Future<void> init() async {
    print("NotificationManager#init");
    //https://pub.dev/packages/awesome_notifications#how-to-show-local-notifications
    //通知チャンネルの設定
    //Initialize the plugin on main.dart, with at least one native icon and one channel
    AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          //Android8以降通知のチャンネル必要。
          channelKey: channelKey,
          channelName: "Alarm Notification",
          channelDescription: "目覚まし",
          defaultColor: Colors.blueAccent,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          importance: NotificationImportance.High,
        ),
      ],
    );

    // Get initial notification action is optional
    await getNotificationAction();
    print("[initialAction]$initialAction");

    //通知の許可が無い場合はユーザーに許可を依頼
    //Request the user authorization to send local and push notifications
    // (Remember to show a dialog alert to the user before call this request)
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        // For Android 14 or greater, the SCHEDULE_EXACT_ALARM permission is denied by default,
        // and you must request it from the users using requestPermissionToSendNotifications.
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod
    );
  }

  static Future<void> getNotificationAction() async {
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  void dispose() {
    actionStreamSubscription?.cancel();
    displayedStreamSubscription?.cancel();
    createdStreamSubscription?.cancel();
  }

  ///通知が作成された際のコールバック（旧createdStream）
  //（ここで登録された通知の取得処理をやらないとパッケージがウラでやっているSharedPreferencesへの登録処理を追い越ししまう）
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("[通知]onNotificationCreatedMethod: $receivedNotification");
    //getAlarmList();
  }

  //表示された通知を押してアプリが起動した際に呼ばれるコールバックみたい（≠通知が表示されたタイミングではない模様：旧displayedStream）
  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("[通知]onNotificationDisplayedMethod: $receivedNotification");
  }

  //通知を開いた際のコールバック（actionStream）
  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("[通知]onActionReceivedMethod: $receivedAction");
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/second-screen',
            (route) => (route.settings.name != '/second-screen') || route.isFirst,
        arguments: receivedAction);
    // Your code goes here
  }

  Future<void> setAlarm(
      {required Alarm alarmData, required bool isNeedDbInsert}) async {
    /*
    * TODO AlarmDataからの変換要 => 複数日設定する場合は同じグループ・別ID
    *  AlarmMode.ONCEの場合は、通知設定１回でOK
    *  AlarmMode.EVERYの場合は、曜日ごとに複数通知設定要
    *  => トグルで有効化（setAlarm）・無効化（cancelAlarm）にしよう
    * */

    if (alarmData.mode == AlarmMode.ONCE) {
      //AlarmMode.ONCEの場合は、通知設定１回でOK
      await createNotification(alarm: alarmData);
    } else {
      //AlarmMode.EVERYの場合は、曜日ごとに複数通知設定要
      final days = [
        alarmData.isMondayEnabled,
        alarmData.isTuesdayEnabled,
        alarmData.isWednesdayEnabled,
        alarmData.isThursdayEnabled,
        alarmData.isFridayEnabled,
        alarmData.isSaturdayEnabled,
        alarmData.isSundayEnabled,
      ];
      for (int i = 0; i < days.length; i++) {
        final isDayValid = days[i];
        if (isDayValid) {
          final index = i + 1;
          await createNotification(alarm: alarmData, weekDayIndex: index);
        }
      }
    }

    //AlarmDataのDriftへの登録（トグル切り替えのみの場合は不要 <= DBにすでに登録されているから）
    if (isNeedDbInsert) await insertAlarmToLocalDb(alarmData);
  }

  Future<void> createNotification(
      {required Alarm alarm, int? weekDayIndex}) async {
    final mode = alarm.mode;
    final nextId = await sharedPrefsManager.getMaxNotificationId() + 1;
    await sharedPrefsManager.setMaxNotificationId(nextId);

    //TODO ローカル時間からUTCへの変換
    final utcSelectedTime = alarm.time.toUtc();

    //この時点でウラでSharedPreferences(Android)/UserDefault(iOS)に永続化されている
    //=> Moorいらない！
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        //idを変えれば複数のアラームが設定できる！ => 一時的にキャンセル
        //id：アラーム１つごと、groupKey:複数のアラームをまとめることができる
        id: nextId,
        groupKey: alarm.groupKey,
        body: DateFormat("H:mm").format(alarm.time),
        channelKey: channelKey,
        title: '[Alarmサンプル] アラーム時刻です',
        //bigPicture or largeIcon is required
        icon: 'resource://drawable/app_icon',
        payload: {'uuid': 'uuid-test'},
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        //autoDismissible: false,
        //これがないとAndroidでは通知がステータスバーに表示されないみたい
        category: NotificationCategory.Reminder,
        // category: NotificationCategory.Alarm, //Alarmで通知が何度も鳴る
      ),

      /*
      * NotificationCalendar.fromDateだと毎日の繰り返しに対応してくれない => NotificationCalenderにしようか
      *  https://github.com/rafaelsetragni/awesome_notifications/issues/303
      *  https://pub.dev/packages/awesome_notifications/versions/0.7.0-beta.4#scheduling-a-notification
      *  https://github.com/rafaelsetragni/awesome_notifications/issues/168
      * */
      schedule: NotificationCalendar(
        //UTCにするにはこうする必要があるらしい
        //https://pub.dev/documentation/awesome_notifications/0.7.0-beta.4/awesome_notifications/AwesomeNotifications/getUtcTimeZoneIdentifier.html
        timeZone: await AwesomeNotifications().getUtcTimeZoneIdentifier(),
        hour: utcSelectedTime.hour,
        minute: utcSelectedTime.minute,
        second: 0,
        repeats: (mode == AlarmMode.EVERY) ? true : false,
        //TODO UTCにするとイギリス時間での曜日になってしまう（ローカル時間のままだと多分ワークする）
        weekday: (mode == AlarmMode.EVERY) ? weekDayIndex : null,
        preciseAlarm: true,
        allowWhileIdle: false,
      ),
    );
  }

  //  コールバックメソッドがstaticなので、そこから呼び出すメソッドもstaticでないといけない
  //TODO AlarmDataのリストに修正要
  //static Future<void> getAlarmList() async {
  Future<List<Alarm>> getAlarms() async {
    //awesome_notificationsに保存されているか確認するため
    final scheduledNotifications =
        await AwesomeNotifications().listScheduledNotifications();
    return await localDbManager.allAlarms;

    // alarms = [];
    // final scheduledNotifications =
    //     await AwesomeNotifications().listScheduledNotifications();
    // print("notifications: ${scheduledNotifications.toString()}");
    // await Future.forEach(
    //   scheduledNotifications,
    //   (NotificationModel notification) {
    //     final scheduleMap = notification.schedule?.toMap();
    //
    //     if (scheduleMap != null) {
    //       //20220610: 表示用の修正
    //       final now = DateTime.now();
    //       final utcDateTime = DateTime.utc(now.year, now.month, now.day,
    //           scheduleMap["hour"], scheduleMap["minute"]);
    //       final adjustedUtcDateTime = (now.isAfter(utcDateTime))
    //           ? utcDateTime.add(Duration(days: 1))
    //           : utcDateTime;
    //
    //       alarms.add(
    //         //[20220520] awesome_notificationのscheduleMapにはUTCであるかどうかは保存されていないのでDateTime.utcで再度UTC化させる必要あり
    //         //https://pub.dev/packages/awesome_notifications/versions/0.7.0-beta.3+2#scheduling-a-notification
    //         //https://api.dart.dev/stable/2.17.1/dart-core/DateTime/DateTime.utc.html
    //         adjustedUtcDateTime.toLocal(),
    //       );
    //     }
    //   },
    // );
  }

  // void cancelAllNotifications() async {
  //   //await notificationsPlugin.cancel(NOTIFICATION_ID);
  //   await AwesomeNotifications().cancelAll();
  //   alarms.clear();
  // }

  Future<void> cancelAlarm(String groupKey) async {
    await AwesomeNotifications().cancelSchedulesByGroupKey(groupKey);
  }

  Future<void> deleteAlarm(String groupKey) async {
    await localDbManager.deleteAlarm(groupKey);
  }

  Future<void> insertAlarmToLocalDb(Alarm alarmData) async {
    await localDbManager.insertAlarm(alarmData);
  }

  Future<void> onEnableChanged(Alarm alarm, bool isEnabled) async {
    final alarmUpdated = alarm.copyWith(isEnabled: isEnabled);
    await localDbManager.updateAlarm(alarmUpdated);
  }
}
