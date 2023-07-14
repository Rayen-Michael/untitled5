import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:social_media_app/utils/utility.dart';

class OneSignalService {
  static Future<String?> getPlayerId() async {
    try {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("5db5727e-b989-432f-8366-51b10047296f");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

      final deviceState = await OneSignal.shared.getDeviceState();
      final playerId = deviceState?.userId;

      return playerId;
    } catch (error) {
      print('Error retrieving OneSignal Player ID: $error');
      return null;
    }
  }
}
