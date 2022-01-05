part of 'pages.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);
  static const String routeName = "/splash";
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }
  _loadSplash() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, checkAuth);
  }
  void checkAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Navigator.pushReplacementNamed(context, Home.routeName);
      ActivityServices.showToast("Welcome Back, " + auth.currentUser.email, Colors.grey);
    } else {
      Navigator.pushReplacementNamed(context, LoginForm.routeName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [Image.asset("assets/images/portolink.png", height: 300)]
        )
      )
    );
  }
}