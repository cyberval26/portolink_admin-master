import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
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
            theme: ThemeData(
              colorScheme: ColorScheme(
                primary: Colors.blue.shade200,
                onPrimary: Colors.black,
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
              '/': (context) => Home(),
              // '/login': (context) => LoginForm(),
              '/register': (context) => Register(),
              // '/profile': (context) => Profile(),
              // '/catalog': (context) => Catalog(),
              '/catalog/new': (context) => NewCatalog(),
              '/catalog/edit': (context) => Profile(),
              // '/requests': (context) => Requests(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text(
          "Loading ",
          textDirection: TextDirection.ltr,
        );
      },
    );
  }
}
