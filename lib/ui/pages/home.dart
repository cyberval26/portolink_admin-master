part of 'pages.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static const String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Admin currentUser = Admin();
  int bnbindex = 0;

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
        print(firebaseUser);
      });
    });
  }

  Widget getHomeContent() {
    switch (bnbindex) {
      case 0:
        {
          return Catalog();
          // return Text(Provider.of<Counter>(context).name);
        }
      case 1:
        {
          return Requests();
        }
      case 2:
        {
          return Profile();
        }
      default:
        {
          return Text("Error 404");
        }
    }
  }

  Widget getHome() {
    if (currentUser.loggedIn) {
      return Scaffold(
        body: getHomeContent(),
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
