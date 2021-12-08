part of 'main.dart';

class User {
  String uid = "", email = "";
  bool verified = false, loggedIn = false;

  User();
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User currentUser = User();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        var firebaseUser = FirebaseAuth.instance.currentUser;
        currentUser.loggedIn = firebaseUser != null;
        if (firebaseUser != null) {
          currentUser.email = firebaseUser.email;
          currentUser.uid = firebaseUser.uid;
          currentUser.verified = firebaseUser.emailVerified;
        }
        (firebaseUser);
      });
    });
  }

  Widget getHomeContents() {
    if (currentUser.loggedIn) {
      return Column(
        children: [
          Expanded(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/requests');
                  },
                  child: const Text("Request Check"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal.shade200)),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/catalog');
                  },
                  child: const Text("Catalog"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal.shade200)),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: const Text("My Account"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal.shade200)),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("Login"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal.shade200)),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text("Register"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal.shade200)),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Portolink Admin")),
      body: Container(
          constraints: const BoxConstraints.expand(), child: getHomeContents()),
    );
  }
}