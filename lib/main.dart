import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Shopping App',
      theme: ThemeData(
          // scaffoldBackgroundColor: Colors.orange,
          backgroundColor: Colors.amber,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color.fromARGB(255, 232, 229, 229)),
      // home: const CategoryScreen(title: 'Smart Shopping App'),
      home: const SplashScreen(),
    );
  }
}
