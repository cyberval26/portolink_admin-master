import 'dart:io';
import 'package:portolink/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}
void main() async {
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "ERROR: ${snapshot.error.toString()} ",
            textDirection: TextDirection.ltr,
          );  
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Portolink',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme(
                primary: Colors.blue.shade200,
                onPrimary: Colors.white,
                primaryVariant: Colors.blue.shade200,
                background: Colors.red,
                onBackground: Colors.black,
                secondary: Colors.red,
                onSecondary: Colors.white,
                secondaryVariant: Colors.deepOrange,
                error: Colors.black,
                onError: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
                brightness: Brightness.light,
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const Splash(),
              LoginForm.routeName: (context) => const LoginForm(),
              Register.routeName: (context) => const Register(),
              Home.routeName: (context) => const Home(),
              AddTemplate.routeName: (context) => const AddTemplate()
            },
          );
        }
        return const Text(
          "Loading ",
          textDirection: TextDirection.ltr,
        );
      },
    );
  }
}