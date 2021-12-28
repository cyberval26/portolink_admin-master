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
      imageQuality: 50,
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
      body: SizedBox(
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
                              prefixIcon: Icon(Icons.drive_file_rename_outline),
                              border: OutlineInputBorder()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fil the field!";
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
                              return "Please fil the field!";
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
                            prefixIcon: Icon(Icons.money),
                            border: OutlineInputBorder()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fil the field!";
                            } else {
                              return null;
                            }
                          }
                        ),
                        const SizedBox(height: 24),
                        imageFile == null
                        ? Row(children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {
                              showFileDialog(context);
                            },
                            icon: const Icon(Icons.folder_outlined),
                            label: const Text("Pick Photo")
                          ),
                          const SizedBox(width: 16),
                          const Text("File not found.",
                          style: TextStyle(color: Colors.red)
                          )
                        ])
                        : Row(children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {
                              showFileDialog(context);
                            },
                            icon: const Icon(Icons.folder_outlined),
                            label: const Text("Repick")
                          ),
                          const SizedBox(width: 16),
                          Semantics(
                            child: Image.file(File(imageFile.path),
                            width: 100)
                          )
                        ]),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Templates template = Templates(
                                "",
                                ctrlName.text,
                                ctrlDesc.text,
                                ctrlPrice.text,
                                ""
                              );
                              await TemplateServices.addTemplate(
                                template, imageFile
                              ).then((value) {
                                if (value == true) {
                                  ActivityServices.showToastBlack(
                                    "Add template successful!",
                                    Colors.grey[200]
                                  );
                                  clearForm();
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  ActivityServices.showToastWhite(
                                  "Add template failed.", Colors.red
                                  );
                                }
                              });
                            } else {
                              ActivityServices.showToastWhite(
                                "Please check all the fields.", Colors.red
                              );
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text("Post Template"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, elevation: 4
                          )
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