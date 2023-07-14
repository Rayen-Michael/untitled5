import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/utils/utility.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(const BibleTabView());
}

class BibleTabView extends StatefulWidget {
  const BibleTabView({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BibleTabView> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String verse = '';
  String reference = '';

  static String channelID = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    fetchVerseOfTheDay();
  }
  void openTaraneem() {
    // Implement the logic for opening the "Taraneem" section
    // when the container is tapped
    AppUtility.showSnackBar("Coming Soon!!!", StringValues.error);
  }

  void openBible() {
    // Implement the logic for opening the "Bible" section
    // when the container is tapped
    AppUtility.showSnackBar("Coming Soon!!!", StringValues.error);
  }
  Future<void> scheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Verse of the Day',
      '$verse\n\n$reference',
      _nextInstanceOf7AM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'General Notifications',
          'Verse of the Day',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOf7AM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 7);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
  Future<void> fetchVerseOfTheDay() async {
    final response = await http.get(
      Uri.parse('https://beta.ourmanna.com/api/v1/get?format=json&order=daily'),
    );
    if (response.statusCode == 200) {
      final verseData = json.decode(response.body);
      final verseDetails = verseData['verse']['details'];
      final verseText = verseDetails['text'] as String?;
      final verseReference = verseDetails['reference'] as String?;
      if (verseText != null && verseReference != null) {
        final verseString = verseText;
        setState(() {
          verse = verseString;
          reference = verseReference;
        });
        // showNotification(verseString);
      } else {
        // Handle the case when 'text' or 'reference' is null
        setState(() {
          verse = 'Rabena Msh Ba2etlak 7aga Enaharda 😂';
          reference = 'Mafeesh';
        });
      }
    } else {
      // Handle the case when response status is not 200
      setState(() {
        verse = 'Di Moshkela Kebeera 🥲 2ool/2ooli li rayen besor3a';
        reference = '.';
      });
    }
  }

  // Future<void> showNotification(String verse) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //     'General Notifications',
  //     'Verse of the Day',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Verse of the Day',
  //     verse,
  //     platformChannelSpecifics,
  //     payload: 'verse',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Container(
          width: 393,
          height: 852,
          decoration: const BoxDecoration(),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 393,
                  height: 275,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                    image: DecorationImage(
                        image: AssetImage(PngWidget.gradientwidget),
                        alignment: Alignment.centerRight),
                  ),
                ),
              ),
              const Positioned(
                top: 42,
                left: 54,
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.cross, // Replace with the actual FontAwesome icon you want to use
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 8), // Add some spacing between the icon and text
                    Text(
                      'Wa2t Ma3 Yasou3',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Potta One',
                        fontSize: 22,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 104,
                left: 21,
                child: Text(
                  'God Says:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    decoration: TextDecoration.none, // Remove underline
                  ),
                ),
              ),
              Positioned(
                top: 152,
                left: 21,
                child: SizedBox(
                  width: 350,
                  child: Text(
                    verse,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                    maxLines: 4, // Adjust the number of lines as needed
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1,
                      decoration: TextDecoration.none, // Remove underline
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 216,
                left: 21,
                child: Container(
                  width: 100,
                  height: 33,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.212),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      reference,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
        top: 344,
        left: 11,
        child: GestureDetector(
          onTap: openBible, // Specify the onTap callback
          child: Container(
            width: 376,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(100, 100, 100, 1),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.bible,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 8),
                Text(
                  'Bible',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
              Positioned(
        top: 567,
        left: 11,
        child: GestureDetector(
          onTap: openTaraneem, // Specify the onTap callback
          child: Container(
            width: 376,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(100, 100, 100, 1),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.music,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 8),
                Text(
                  'Kalimat El Taraneem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}
