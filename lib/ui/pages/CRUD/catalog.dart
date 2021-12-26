part of '../pages.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key key}) : super(key: key);
  static const String routeName = "/catalog";
  @override
  _CatalogState createState() => _CatalogState();
}
class _CatalogState extends State<Catalog> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference productCollection = FirebaseFirestore.instance.collection("Templates");
  Widget buildBody() {
    return Container(
      color: Colors.black12,
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: productCollection.snapshots(),
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
              if (doc['tid'] == FirebaseAuth.instance.currentUser.uid) {
                templates = Templates(
                  doc['tid'],
                  doc['name'],
                  doc['desc'],
                  doc['price'],
                  doc['photo']
                );
              }
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
      appBar: AppBar(
        title: const Text("List Templates"),
        centerTitle: true
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}