part of 'pages.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key key}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}
class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference admCollection = FirebaseFirestore.instance.collection("admins");
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
            return Stack(
              children: snapshot.data.docs.map((DocumentSnapshot doc) {
                Admins admins;
                if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
                  admins = Admins(
                    doc['uid'],
                    doc['aName'],
                    doc['aEmail'],
                    doc['aPass'],
                    doc['createdAt'],
                    doc['updatedAt']
                  );
                }
                return AccountView(admins: admins);
              }).toList()
            );
          },  
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody()
    );
  }
}