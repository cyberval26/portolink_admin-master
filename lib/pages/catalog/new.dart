part of '../pages.dart';

class NewCatalog extends StatefulWidget {
  NewCatalog({Key? key}) : super(key: key);

  @override
  _NewCatalogState createState() => _NewCatalogState();
}

class _NewCatalogState extends State<NewCatalog> {
  final textTemplateNameController = TextEditingController();
  final textDescriptionController = TextEditingController();
  final textPriceController = TextEditingController();

  late File catalogPicture;
  // Admin currentUser = Admin();

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseAuth.instance.authStateChanges().listen((event) {
  //     setState(() {
  //       var firebaseUser = FirebaseAuth.instance.currentUser;
  //       currentUser.loggedIn = firebaseUser != null;
  //       if (currentUser.loggedIn) {
  //         currentUser.email = firebaseUser!.email!;
  //         currentUser.uid = firebaseUser.uid;
  //         currentUser.verified = firebaseUser.emailVerified;
  //       }
  //       print(firebaseUser);
  //     });
  //   });
  // }
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      catalogPicture = File(pickedFile!.path);
    });
  }

  void submit() {
    CollectionReference catalogs =
        FirebaseFirestore.instance.collection('catalog');

    catalogs.add({
      'TemplateName': textTemplateNameController.text,
      'Description': textDescriptionController.text,
      'Price': textPriceController.text,
    }).then((value) {
      // FirebaseStorage storage = FirebaseStorage.instance;
      // Reference ref = storage.ref().child("catalog/" + value.id);
      // UploadTask uploadTask = ref.putFile(recipePicture);
      // uploadTask.then((res) {
      //  print(res.ref.getDownloadURL());
      //   Navigator.pop(context);
      // });
    }).catchError((error) => print("Failed to add catalog: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add A New Catalog Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text('Upload image')),
            TextField(
              controller: textTemplateNameController,
              autocorrect: false,
              decoration: const InputDecoration(labelText: "Template Name"),
            ),
            TextField(
              controller: textPriceController,
              autocorrect: false,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: textDescriptionController,
              autocorrect: false,
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              scrollPadding: EdgeInsets.all(20.0),
              maxLines: null,
              maxLength: null,
            ),
            ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
