part of 'pages.dart';

class Catalog extends StatefulWidget {
  Catalog({Key key}) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog List"),
      ),
      body: Column(
        children: [ElevatedButton(onPressed: () {}, child: Text("Upload"))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
