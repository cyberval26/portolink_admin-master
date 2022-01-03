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
              Row(mainAxisAlignment: MainAxisAlignment.center,),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.black54
                  ),
                  Text(
                    "\t\t\t" + admins.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24)
                  ),
                ]
              )
            ]
          )
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
                  ActivityServices.showToastWhite("Logout Success");
                  Navigator.pushReplacementNamed(
                      context, LoginForm.routeName);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ActivityServices.showToastBlack("Logout Failed");
                }
              });
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          )
        )
      ]
    );
  }
}