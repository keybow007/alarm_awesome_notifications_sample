import 'package:alarm_local_notifications_sample/data/alarm_data.dart';
import 'package:alarm_local_notifications_sample/model/notification_manager.dart';
import 'package:alarm_local_notifications_sample/model/shared_prefs_manager.dart';
import 'package:alarm_local_notifications_sample/view/screens/home_screen.dart';
import 'package:alarm_local_notifications_sample/view/screens/second_screen.dart';
import 'package:alarm_local_notifications_sample/view_model/view_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  runApp(
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
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      // The navigator key is necessary to allow to navigate through static methods
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) =>
                HomeScreen()
            );

          case '/second-screen':
            return MaterialPageRoute(builder: (context) {
              final ReceivedAction receivedAction = settings
                  .arguments as ReceivedAction;
              return SecondScreen();
            });

          default:
            assert(false, 'Page ${settings.name} not found');
            return null;
        }
      },
    );
  }
}
