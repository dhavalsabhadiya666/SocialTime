import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    AMapServices.shared().apiKey = "b2b9d40de46cffe14a532338e4eb74b1"
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
