part of 'pages.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key key}) : super(key: key);
  static const String routeName = "/catalog";
  @override
  _CatalogState createState() => _CatalogState();
}
class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
      ),
    );
  }
}