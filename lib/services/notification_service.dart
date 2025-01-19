import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize timezones
    tz.initializeTimeZones();

    var androidInitialization = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialization);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification() async {
    // Request permission for exact alarms (needed for Android 12+)
    await Permission.notification.request();
    await Permission.scheduleExactAlarm.request();

    // If permissions are granted, proceed with scheduling the notification
    if (await Permission.scheduleExactAlarm.isGranted) {
      // Get the current time in the local timezone
      final skopjeLocation = tz.getLocation('Europe/Skopje'); // CET timezone
      var now = tz.TZDateTime.now(skopjeLocation);
      print("permission for alarm is granted");
      // Calculate the time for 4:30 PM today
      var targetTime = tz.TZDateTime(skopjeLocation, now.year, now.month, now.day, 16, 52);

      // If the target time is in the past, schedule for 4:30 PM tomorrow
      if (now.isAfter(targetTime)) {
        targetTime = targetTime.add(Duration(days: 1));
      }
       print("target time is :$targetTime");
      var androidDetails = AndroidNotificationDetails(
        'joke_channel_id', // Channel ID
        'Joke of the Day', // Channel name
        channelDescription: 'Receive a daily joke notification',
        importance: Importance.high, // High importance for visibility
        priority: Priority.high, // High priority for timely delivery
      );

      var platformDetails = NotificationDetails(android: androidDetails);


      try {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          0, // Notification ID
          'Joke of the Day', // Title
          'Here is your daily joke!', // Body message
          targetTime, // The time at which to show the notification
          platformDetails, // Platform-specific details
          androidAllowWhileIdle: true, // Allows notification to show while idle
          matchDateTimeComponents: DateTimeComponents.time, // Only match time for daily repeat
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime, // Match the wall clock time
        );
        print("Notification successfully scheduled for 4:52 PM.");
      } catch (e) {
        print("Error scheduling notification: $e");
      }
    } else {
      print("Permission for exact alarms not granted");
    }
  }
}
