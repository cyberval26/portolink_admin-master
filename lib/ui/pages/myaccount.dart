part of 'pages.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key key}) : super(key: key);
  static const String routeName = "/myaccount";
  @override
  _MyAccountState createState() => _MyAccountState();
}
class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference admCollection = FirebaseFirestore.instance.collection("users");
  Widget buildBody() {
    return Container(
      color: Colors.black12,
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: admCollection.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Failed to load data!");
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return ActivityServices.loadings();
            }
            return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot doc) {
                  if (doc.data()['uid'] == FirebaseAuth.instance.currentUser.uid) {
                    admins = new Admins(
                      doc.data()['uid'],
                      doc.data()['aName'],
                      doc.data()['aEmail'],
                      doc.data()['aPass'],
                      doc.data()['createdAt'],
                      doc.data()['updateAt']
                    );
                  }
                }).toList()
            );
          },  
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true),
        resizeToAvoidBottomInset: false,
        body: buildBody()
    );
  }
}
// class _MyAccountState extends State<MyAccount > {
//   logout() {
//     FirebaseAuth.instance.signOut();
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("MyAccount "),
//       ),
//       body: ElevatedButton(onPressed: logout, child: const Text("Logout")),
//     );
//   }
// }