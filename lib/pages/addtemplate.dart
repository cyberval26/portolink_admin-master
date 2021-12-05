part of '../main.dart';

class AddTemplate extends StatefulWidget {
  AddTemplate({Key? key}) : super(key: key);

  @override
  _AddTemplateState createState() => _AddTemplateState();
}

class _AddTemplateState extends State<AddTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
    );
  }
}
