import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portolink/ui/pages/pages.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}
class _AppState extends State<App> {
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
            debugShowCheckedModeBanner: false,
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
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => Home(),
              '/login': (context) => LoginForm(),
              '/register': (context) => Register(),
              '/myaccount': (context) => MyAccount(),
              '/catalog': (context) => Catalog(),
              '/catalog/new': (context) => Profile(),
              '/catalog/edit': (context) => Profile(),
              '/requests': (context) => Requests(),
              AddTemplate.routeName: (context) => AddTemplate()
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
