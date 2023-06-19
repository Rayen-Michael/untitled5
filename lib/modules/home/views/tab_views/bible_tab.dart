import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/constants/assets.dart';

void main() {
  runApp(BibleTabView());
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

  static String channelID = Uuid().v4();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    fetchVerseOfTheDay();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(AssetValues.appIcon);
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
        final verseString = '$verseText - $verseReference';
        setState(() {
          verse = verseString;
        });
        showNotification(verseString);
      } else {
        // Handle the case when 'text' or 'reference' is null
        setState(() {
          verse = 'Rabena Msh Ba2etlak 7aga Enaharda 😂';
        });
      }
    } else {
      // Handle the case when response status is not 200
      setState(() {
        verse = 'Di Moshkela Kebeera 🥲 2ool/2ooli li rayen besor3a';
      });
    }
  }

  Future<void> showNotification(String verse) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'General Notifications',
      'Verse of the Day',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Verse of the Day',
      verse,
      platformChannelSpecifics,
      payload: 'verse',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Figma Flutter Generator Iphone14pro1Widget - FRAME
        home: Container(
            width: 393,
            height: 852,
            decoration: BoxDecoration(
              color : Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          width: 393,
                          height: 275,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36),
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            ),
                            image : DecorationImage(
                                image: AssetImage('assets/images/Newproject21.png'),
                                fit: BoxFit.fitWidth
                            ),
                          )
                      )
                  ),Positioned(
                      top: 42,
                      left: 54,
                      child: Text('Wa2t Ma3 Yasou3', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Potta One',
                          fontSize: 24,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 104,
                      left: 21,
                      child: Text('God Says:', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 375,
                      left: 88,
                      child: SvgPicture.asset(
                          'assets/images/vector.svg',
                          semanticsLabel: 'vector'
                      )
                  ),Positioned(
                      top: 152,
                      left: 21,
                      child: Text('Do not merely listen to the word, and so deceive yourselves. Do what it says.', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 216,
                      left: 21,
                      child: Container(
                          width: 100,
                          height: 33,
                          decoration: BoxDecoration(
                            color : Color.fromRGBO(255, 255, 255, 1),
                          )
                      )
                  ),Positioned(
                      top: 220,
                      left: 28,
                      child: Text('James 1:22', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 344,
                      left: 11,
                      child: Container(
                          width: 376,
                          height: 146,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color : Color.fromRGBO(239, 241, 243, 1),
                          )
                      )
                  ),Positioned(
                      top: 792,
                      left: 0,
                      child: Container(
                          width: 393,
                          height: 62,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color : Color.fromRGBO(239, 241, 243, 1),
                          )
                      )
                  ),Positioned(
                      top: 567,
                      left: 11,
                      child: Container(
                          width: 376,
                          height: 146,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color : Color.fromRGBO(239, 241, 243, 1),
                          )
                      )
                  ),Positioned(
                      top: 48,
                      left: 26,
                      child: SvgPicture.asset(
                          'assets/images/vector.svg',
                          semanticsLabel: 'vector'
                      )
                  ),Positioned(
                      top: 806,
                      left: 293,
                      child: Container(
                          width: 100,
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            color : Color.fromRGBO(254, 115, 89, 1),
                          )
                      )
                  ),Positioned(
                      top: 811,
                      left: 21,
                      child: Text('3ayez Tekallem Ta2ed Mn El Kada', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 811,
                      left: 299,
                      child: Text('Doos Hena!', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 368,
                      left: 162,
                      child: SvgPicture.asset(
                          'assets/images/vector.svg',
                          semanticsLabel: 'vector'
                      )
                  ),Positioned(
                      top: 455,
                      left: 163,
                      child: Text('Bible', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),Positioned(
                      top: 591,
                      left: 157,
                      child: SvgPicture.asset(
                          'assets/images/vector.svg',
                          semanticsLabel: 'vector'
                      )
                  ),const Positioned(
                      top: 678,
                      left: 135,
                      child: Text('Taraneem', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)
                  ),
                ]
            )
        )
    );
  }
}
