import UIKit
import awesome_notifications
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       
      if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }
      GeneratedPluginRegistrant.register(with: self)
      //Extra iOS Setup for Background Actions
      //https://pub.dev/packages/awesome_notifications#-extra-ios-setup-for-background-actions
     //https://stackoverflow.com/a/75033554/7300575
      // This function registers the desired plugins to be used within a notification background action
    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
              SwiftAwesomeNotificationsPlugin.register(
                with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
          }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
