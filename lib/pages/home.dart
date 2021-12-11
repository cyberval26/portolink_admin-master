part of 'pages.dart';

class User {
  String uid = "", email = "";
  bool verified = false, loggedIn = false;

  User();
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User currentUser = User();
  int bnbindex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        var firebaseUser = FirebaseAuth.instance.currentUser;
        currentUser.loggedIn = firebaseUser != null;
        if (firebaseUser != null) {
          currentUser.email = firebaseUser.email!;
          currentUser.uid = firebaseUser.uid;
          currentUser.verified = firebaseUser.emailVerified;
        }
        print(firebaseUser);
      });
    });
  }

  Widget getHome() {
    if (currentUser.loggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text("Portolink Admin")),
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
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
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.home),
            //   label: 'Home',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Catalog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Profile',
            ),
          ],
          currentIndex: bnbindex,
          // selectedItemColor: Colors.red,
          // unselectedItemColor: Colors.black87,
          // backgroundColor: Colors.orange,
          onTap: (index) {
            setState(() {
              bnbindex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("Portolink Admin")),
        body: Container(
            constraints: const BoxConstraints.expand(), child: LoginForm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getHome();
  }
}
