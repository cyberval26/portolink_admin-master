part of 'pages.dart';

class Finished extends StatefulWidget {
  const Finished({Key key}) : super(key: key);
  @override
  _FinishedState createState() => _FinishedState();
}
class _FinishedState extends State<Finished> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference templateCollection = FirebaseFirestore.instance.collection("Orders");
  Widget buildBody() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: templateCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Failed to load data!");
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return ActivityServices.loadings();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot doc) {
                Requests requests;
               if(doc['status'] == "Finished") {
                 requests = Requests(
                    doc['orderId'],
                    doc['templateName'],
                    doc['color'],
                    doc['contact'],
                    doc['requestDescription'],
                    doc['photoReference'],
                    doc['addBy'],
                    doc['pendingBy'],
                    doc['status'],
                    doc['createdAt']
                 );
               }
              return ApprovedView(requests: requests);
            }).toList()
          );
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildBody()
    );
  }
}