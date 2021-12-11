part of 'widgets.dart';

class AccountView extends StatefulWidget {
  final Admins admins;
  // ignore_for_file: prefer_const_constructors_in_immutables
  // ignore: use_key_in_widget_constructors
  AccountView({this.admins});
  @override
  _AccountViewState createState() => _AccountViewState();
}
class _AccountViewState extends State<AccountView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Admins admins = widget.admins;
    return Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 200
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: Colors.black, size: 50),
                    Text(admins.aName, style: const TextStyle(fontSize: 30))
                  ],
                ),
               const  SizedBox(
                  height: 20
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, color: Colors.black, size: 50),
                    Text(admins.aEmail, style: const TextStyle(fontSize: 30))
                  ],
                ),
                const SizedBox(
                  height: 200
                )
              ]
            ),
          ),
          Container(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await AuthServices.signOut().then((value) {
                  if (value == true) {
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast("Logout Success", Colors.green);
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast("Logout Failed", Colors.red);
                  }
                });
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                elevation: 0,
              )),
        ),
      ]);
  }
}