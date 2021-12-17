part of 'widgets.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key key, this.admins}) : super(key: key);
  final Admins admins;
  @override
  _AccountViewState createState() => _AccountViewState();
}
class _AccountViewState extends State<AccountView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Admins admins = widget.admins;
    if (admins == null) {
      ActivityServices.showToast2("Can't load your profile", const Color(0xFFFF0000));
      return Container();
    }
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              Image.asset("assets/images/portolink.png", height: 300),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.black54
                  ),
                  Text(
                    "" + admins.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24)
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.black54
                  ),
                  Text(
                    "" + admins.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24)
                  ),
                ],
              ),
            ],
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
                  ActivityServices.showToast("Logout Success", Colors.grey[300]);
                  Navigator.pushReplacementNamed(
                      context, LoginForm.routeName);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ActivityServices.showToast("Logout Failed", const Color(0xFFFF0000));
                }
              });
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              primary: Colors.teal[200],
              onPrimary: Colors.white,
              elevation: 4
            )
          ),
        ),
      ],
    );
  }
}