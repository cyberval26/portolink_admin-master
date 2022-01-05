part of 'pages.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  bool isLoading = false;
  CollectionReference admCollection = FirebaseFirestore.instance.collection("Admins");
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: admCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Failed to load data");
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return ActivityServices.loadings();
          }
          return Stack(
            children: snapshot.data.docs.map((DocumentSnapshot doc) {
              Admins admins;
              if (doc['aid'] == FirebaseAuth.instance.currentUser.uid) {
                admins = Admins(
                  doc['aid'],
                  doc['email'],
                  doc['pass'],
                  doc['createdAt'],
                  doc['updatedAt']
                );
              }
              return AccountView(admins: admins);
            }).toList()
          );
        }
      )
    );
  }
}