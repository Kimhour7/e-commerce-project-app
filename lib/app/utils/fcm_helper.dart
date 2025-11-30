import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../firebase_options.dart';
import 'awesomeNotificationsHelper.dart';

class FcmHelper {
  // prevent making instance
  FcmHelper._();
  // FCM Messaging
  static late FirebaseMessaging messaging;

  /// this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    try {
      // initialize fcm and firebase core
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // initialize firebase
      messaging = FirebaseMessaging.instance;
      // notification settings handler
      await _setupFcmNotificationSettings();
      // generate token if it not already generated and store it on shared pref
      await _generateFcmToken();
      // send message for multiple devices
      FirebaseMessaging.instance.subscribeToTopic('NITH');
      // background and foreground handlers
      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    } catch (error) {
      // if you are connected to firebase and still get error
      // check the todo up in the function else ignore the error
      // or stop fcm service from main.dart class
      // Logger().e(error);
    }
  }

  ///handle fcm notification settings (sound,badge..etc)
  static Future<void> _setupFcmNotificationSettings() async {
    //show notification with sound and badge
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  /// generate and save fcm token if its not already generated (generate only for 1 time)
  static Future<void> _generateFcmToken() async {
    try {
      var token = await messaging.getToken();
      if (token != null) {
        print("token : $token");
        // MySharedPref.setFcmToken(token);
        // StorageService.setFcmToken(token);
        _sendFcmTokenToServer();
      } else {
        // retry generating token
        await Future.delayed(const Duration(seconds: 5));
        _generateFcmToken();
      }
    } catch (error) {
      // Logger().e(error);
    }
  }

  /// this method will be triggered when the app generate fcm
  /// token successfully
  static _sendFcmTokenToServer() async {
    // var token = StorageService.read('fcm_token');
    // // check is authenticated
    // var isAuthenticated = StorageService.read('isAuthenticated');
    // if (token != null && isAuthenticated != null && isAuthenticated) {
    // // TODO SEND FCM TOKEN TO SERVER
    // await AuthNetworkService.to.sendDeviceToken(deviceToken: token);
    // }
  }

  ///handle fcm notification when app is closed/terminated
  /// if you are wondering about this annotation read the following
  /// https://stackoverflow.com/a/67083337
  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    // print("background message : ${message.data}");
    if (message.data.isEmpty && message.data['title'] == null) {
      return;
    }
    // check if platform is android
    if (GetPlatform.isAndroid) {
      AwesomeNotificationsHelper.showNotification(
        id: 1,
        title: message.data['title'] ?? 'Tittle',
        body: message.data['body'] ?? 'Body',
        payload: message.data
            .cast(), // pass payload to the notification card so you can use it (when user click on notificatio
        actionButtons: [],
        notificationLayout: NotificationLayout.Default,
      );
    }
    // if platform is ios
    if (GetPlatform.isIOS) {
      AwesomeNotificationsHelper.showNotification(
        id: 1,
        title: message.notification?.title ?? 'Tittle',
        body: message.notification?.body ?? 'Body',
        payload: message.data
            .cast(), // pass payload to the notification card so you can use it (when user click on notificatio
        actionButtons: [],
        notificationLayout: NotificationLayout.Default,
      );
    }
  }

  //handle fcm notification when app is open
  static Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    print("foreground message : ${message.data}");
    // if (message.data.isEmpty && message.data['title'] == null) {
    //   return;
    // }
    if (GetPlatform.isAndroid) {
      AwesomeNotificationsHelper.showNotification(
        id: 1,
        title: message.data['title'] ?? 'Tittle',
        body: message.data['body'] ?? 'Body',
        payload: message.data
            .cast(), // pass payload to the notification card so you can use it (when user click on notificatio
        actionButtons: [],
        notificationLayout: NotificationLayout.Default,
      );
    }
    // navigate to notification screen
    // Get.toNamed(NotificationScreen.route);
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    // print("onMessageOpenApp message : ${message.data}");
    if (message.data.isEmpty && message.data['title'] == null) {
      return;
    }
    if (GetPlatform.isAndroid) {
      AwesomeNotificationsHelper.showNotification(
        id: 1,
        title: message.data['title'] ?? 'Tittle',
        body: message.data['body'] ?? 'Body',
        payload: message.data
            .cast(), // pass payload to the notification card so you can use it (when user click on notificatio
      );
    }
  }
}
