import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       // flutter_local_notification
       //https://pub.dev/packages/flutter_local_notifications/versions/10.0.0-dev.19#general-setup
       if #available(iOS 10.0, *) {
             UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
       }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
