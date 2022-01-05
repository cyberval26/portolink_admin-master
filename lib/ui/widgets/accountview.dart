part of 'widgets.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key key, this.admins}) : super(key: key);
  final Admins admins;
  @override
  _AccountViewState createState() => _AccountViewState();
}

_prefixIcon(IconData iconData) {
  return ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
    child: Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.blue[100].withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.blue,
        )),
  );
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
          padding: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: ListView(
           // shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              Image.asset("assets/images/portolink.png", height: 300),
              const SizedBox(height: 15),
              Row(
                children: [
                  _prefixIcon(Icons.email),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Email',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: Colors.black)),
                      SizedBox(height: 1),
                      Text(admins.email),
                    ],
                  ),
                ],
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.black54
                  ),
                  Text(
                    "    " + admins.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24)
                  ),
                ]
              )
            ]
          )
        ),
        Align(
          alignment: const AlignmentDirectional(0, 0.7),
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
                  ActivityServices.showToast("Logout Success", Colors.grey);
                  Navigator.pushReplacementNamed(context, LoginForm.routeName);
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
          )
        ),
      ]
    );
  }
}