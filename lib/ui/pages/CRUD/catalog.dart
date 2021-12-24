part of '../pages.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key key}) : super(key: key);
  static const String routeName = "/catalog";
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  void initState() {
    super.initState();
    TemplateServices.getTemplates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtemplate');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
