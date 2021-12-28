part of '../pages.dart';

class AddTemplate extends StatefulWidget {
  const AddTemplate({Key key}) : super(key: key);
  static const String routeName = "/addtemplate";
  @override
  _AddTemplateState createState() => _AddTemplateState();
}
class _AddTemplateState extends State<AddTemplate> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPrice = TextEditingController();
  bool isLoading = false;
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();
  Future chooseFile(String type) async {
    ImageSource imgSrc;
    if (type == "camera") {
      imgSrc = ImageSource.camera;
    } else if (type == "gallery") {
      imgSrc = ImageSource.gallery;
    }
    final selectedImage = await imagePicker.pickImage(
      source: imgSrc,
      imageQuality: 100,
    );
    setState(() {
      imageFile = selectedImage as PickedFile;
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
                chooseFile("camera");
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Camera"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                chooseFile("gallery");
              },
              icon: const Icon(Icons.folder_outlined),
              label: const Text("Gallery"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
          ],
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Template'),
        centerTitle: true
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white, filled: true,
                            labelText: "Product Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fil the field!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: ctrlDesc,
                          keyboardType: TextInputType.name,
                          maxLines: 3,
                          decoration: InputDecoration(
                            fillColor: Colors.white, filled: true,
                            labelText: "Product Description",
                            prefixIcon: Icon(Icons.description),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fil the field!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: ctrlPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.white, filled: true,
                            labelText: "Product Price",
                            prefixIcon: Icon(Icons.money),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fil the field!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        imageFile == null
                            ? Row(
                                children: <Widget>[
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showFileDialog(context);
                                    },
                                    icon: Icon(Icons.photo_camera),
                                    label: Text("Ambil Foto"),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text("File not found.", style: TextStyle(color: Colors.red))
                                ],
                              )
                            : Row(
                                children: <Widget>[
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showFileDialog(context);
                                    },
                                    icon: Icon(Icons.photo_camera),
                                    label: Text("Ulangi Foto"),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Semantics(
                                    child: Image.file(
                                      File(imageFile.path),
                                      width: 100,
                                    ),
                                  )
                                ],
                              ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              //melanjutkan ke tahap berikutnya
                              setState(() {
                                isLoading = true;
                              });
                              Templates templates = Templates(
                                "",
                                ctrlName.text,
                                ctrlDesc.text,
                                ctrlPrice.text,
                                "",
                              );
                              await TemplateServices.addTemplate(
                                      templates, imageFile)
                                  .then((value) {
                                if (value == true) {
                                  ActivityServices.showToastBlack(
                                      "Add product successful!", Colors.green);
                                  clearForm();
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  ActivityServices.showToastWhite(
                                      "Add product failed.", Colors.red);
                                }
                              });
                            } else {
                              //kosongkan aja
                              ActivityServices.showToastWhite(
                                  "Please check all the fields.", Colors.red);
                            }
                          },
                          icon: Icon(Icons.save),
                          label: Text("Save Product"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green, elevation: 4),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}