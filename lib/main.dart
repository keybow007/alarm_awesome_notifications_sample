import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:alarm_local_notifications_sample/model/notification_manager.dart';
import 'package:alarm_local_notifications_sample/model/shared_prefs_manager.dart';
import 'package:alarm_local_notifications_sample/view/screens/home_screen.dart';
import 'package:alarm_local_notifications_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider<SharedPrefsManager>(
            create: (context) => SharedPrefsManager(),
          ),
          Provider<MyDatabase>(
            create: (context) => MyDatabase(),
          ),
          Provider<NotificationManager>(
            create: (context) => NotificationManager(
              sharedPrefsManager: context.read<SharedPrefsManager>(),
              localDbManager: context.read<MyDatabase>(),
            ),
          ),
          ChangeNotifierProvider<ViewModel>(
            create: (context) => ViewModel(
              notificationManager: context.read<NotificationManager>(),
            ),
          )
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
