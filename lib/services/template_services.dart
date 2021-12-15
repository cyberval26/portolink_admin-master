part of 'services.dart';

class TemplateServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference tCollection = FirebaseFirestore.instance.collection("templates");
  static DocumentReference tDoc;
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;
  static Future<bool> addTemplate(Templates templates, PickedFile imgFile) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    tDoc = await tCollection.add({
      'tid': templates.tid,
      'name': templates.name,
      'desc': templates.desc,
      'price': templates.price,
      'photo': templates.photo,
      'createdAt': dateNow,
      'updatedAt': dateNow
    });
    if (tDoc != null) {
      ref = FirebaseStorage.instance.ref().child("images").child(tDoc.id + ".jpg");
      uploadTask = ref.putFile(File(imgFile.path));
      await uploadTask.whenComplete(() => ref.getDownloadURL().then((value) => imgUrl = value));
      tCollection.doc(tDoc.id).update({'tid': tDoc.id, 'photo': imgUrl});
      return true;
    } else {
        return false;
      }
  }
  static Future<bool> deleteTemplate(String id) async {
    bool result = true;
    await Firebase.initializeApp();
    await tCollection.doc(id).delete().then((value) {
      result = true;
    }).catchError((onError) {
      result = false;
    });
    return result;
  }
}