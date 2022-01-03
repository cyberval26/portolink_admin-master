part of '../pages.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key key}) : super(key: key);
  @override
  _CatalogState createState() => _CatalogState();
}
class _CatalogState extends State<Catalog> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference templateCollection = FirebaseFirestore.instance.collection("Templates");
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
              Templates templates;
                templates = Templates(
                  doc['tid'],
                  doc['name'],
                  doc['desc'],
                  doc['price'],
                  doc['photo']
                );
              return TemplateView(templates: templates);
            }).toList()
          );
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtemplate');
        },
        child: const Icon(Icons.add)
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody()
    );
  }
}