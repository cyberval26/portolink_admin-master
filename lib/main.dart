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
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(
            "ERROR: ${snapshot.error.toString()} ",
            textDirection: TextDirection.ltr,
          );  
        }

        // Once complete, show your application
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
              // elevatedButtonTheme: ElevatedButtonThemeData(
              //   style: TextButton.styleFrom(
              //       backgroundColor: Colors.teal.shade200,
              //       textStyle: const TextStyle(color: Colors.white)),
              // ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const Home(),
              Register.routeName: (context) => const Register(),
              LoginForm.routeName: (context) => const LoginForm(),
              Catalog.routeName: (context) => const Catalog(),
              AddTemplate.routeName: (context) => const AddTemplate(),
              Home.routeName: (context) => const Home()
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