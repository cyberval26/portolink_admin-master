part of 'pages.dart';

class AddTemplate extends StatefulWidget {
  const AddTemplate({Key key}) : super(key: key);
  static const String routeName = "/addtemplate";
  @override
  _AddTemplateState createState() => _AddTemplateState();
}
class _AddTemplateState extends State<AddTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
      ),
    );
  }
}
