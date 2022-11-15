import 'package:firebase_chat_module/providers/chat_provider.dart';
import 'package:firebase_chat_module/screen/message_screen.dart';
import 'package:firebase_chat_module/utils/get_it.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<ChatProvider>()),
      ],
      child: MaterialApp(
        title: 'Firebase Chat Module',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MessageScreen(),
      ),
    );
  }
}
