part of 'main.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ElevatedButton(onPressed: logout, child: const Text("Logout")),
    );
  }
}