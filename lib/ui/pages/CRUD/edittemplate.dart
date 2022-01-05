part of '../pages.dart';

class EditTemplate extends StatefulWidget {
  const EditTemplate({Key key, this.tid, this.name, this.desc, this.price, this.photo}) : super(key: key);
  static const String routeName = "/edittemplate";
  final String tid; 
  final String name;
  final String desc;
  final String price;
  final String photo;
  @override
  _EditTemplateState createState() => _EditTemplateState();
}
class _EditTemplateState extends State<EditTemplate> {
  String args;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPrice = TextEditingController();
  bool isLoading = false;
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();
  @override
  void initState() {
    ctrlName.text = widget.name;
    ctrlDesc.text = widget.desc;
    ctrlPrice.text = widget.price;
    super.initState();
  }
  Future chooseFile(String type) async {
    ImageSource imgSrc = ImageSource.gallery;
    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 100
    );
    setState(() {
      imageFile = selectedImage;
    });
  }
  void showFileDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Pick image from:"),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                chooseFile("gallery");
              },
              icon: const Icon(Icons.folder_outlined),
              label: const Text("Gallery"),
              style: ElevatedButton.styleFrom(elevation: 0)
            )
          ]
        );
      }
    );
  }
  @override
  void dispose() {
    ctrlName.dispose();
    ctrlDesc.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }
  void clearForm() {
    ctrlName.clear();
    ctrlDesc.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Template'),
        centerTitle: true
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Template Name",
                            prefixIcon: Icon(Icons.bookmark),
                            border: OutlineInputBorder()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          }
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: ctrlDesc,
                          keyboardType: TextInputType.name,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Template Description",
                            prefixIcon: Icon(Icons.description),
                            border: OutlineInputBorder()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          }
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: ctrlPrice,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Template Price",
                            prefixIcon: Icon(Icons.attach_money),
                            border: OutlineInputBorder()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          }
                        ),
                        const SizedBox(height: 24),
                        imageFile == null
                        ? Row(
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: () {
                                showFileDialog(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text("Repick")
                            ),
                            const SizedBox(width: 16),
                            Image.network(widget.photo, width: 100)
                          ]
                        )
                        : Row(
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: () {
                                showFileDialog(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text("Repick")
                            ),
                            const SizedBox(width: 16),
                            Semantics(child: Image.file(File(imageFile.path), width: 100))
                          ]
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Templates templates = Templates(
                                "",
                                ctrlName.text,
                                ctrlDesc.text,
                                ctrlPrice.text,
                                ""
                              );
                              await TemplateServices.updateTemplate(templates, imageFile, widget.tid, widget.photo).then((value) {
                                if (value == true) {
                                  ActivityServices.showToast("Update Template Success", Colors.grey);
                                  clearForm();
                                  Navigator.pushReplacementNamed(context, Home.routeName);
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  ActivityServices.showToast("Update Template Failed", Colors.red);
                                }
                              });
                            } else {
                              ActivityServices.showToast("Please check all the fields", Colors.red);
                            }
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text("Update Template"),
                          style: ElevatedButton.styleFrom(primary: Colors.green, elevation: 4)
                        )
                      ]
                    )
                  )
                )
              ]
            ),
            isLoading == true
            ? ActivityServices.loadings()
            : Container()
          ]
        )
      )
    );
  }
}