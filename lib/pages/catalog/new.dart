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

  List<File?> catalogPicture = [null, null, null, null, null];
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

  Future pickImage(index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      catalogPicture[index] = File(pickedFile!.path);
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

  Widget getUploader(index) {
    if (catalogPicture[index] == null) {
      return ElevatedButton(
          onPressed: () {
            pickImage(index);
          },
          child: Text('Upload image'));
    } else {
      return Container(
        // child: Image(
        //   image: FileImage(catalogPicture!),
        // ),
        child: IconButton(
          iconSize: 150,
          onPressed: () {
            pickImage(index);
          },
          icon: Image(
            image: FileImage(catalogPicture[index]!),
          ),
        ),
      );
    }
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
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  getUploader(0),
                  getUploader(1),
                  getUploader(2),
                  getUploader(3),
                  getUploader(4),
                ],
              ),
            ),
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
