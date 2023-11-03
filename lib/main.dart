import 'package:flutter/material.dart';
import 'package:push/pages/home.dart';
import 'package:push/pages/message.dart';
import 'package:push/providers/push.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationService.messagesStream.listen((event) {
      print('App: $event');
      navigatorKey.currentState?.pushNamed('messages', arguments: event);
      final snackBar = SnackBar(content: Text(event));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      //navegar
      scaffoldMessengerKey: messengerKey,
      //Snacks
      routes: {
        'home': (_) => Home(),
        'messages': (_) => Message(),
      },
    );
  }
}
