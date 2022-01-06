part of 'services.dart';

class TemplateServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference tCollection = FirebaseFirestore.instance.collection("Templates");
  static DocumentReference tDoc;
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;
  static Future<Templates> getSingleTemplate(String id) async {
    Templates templates;
    var tData = await tCollection.doc(id).get();
    var data = tData.data() as Map;
    templates = Templates(data["tid"], data["name"], data["desc"], data["price"], data["photo"]);
    return templates;
  }
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
      ref = FirebaseStorage.instance.ref().child("TemplatePhotos").child(tDoc.id + ".jpg");
      uploadTask = ref.putFile(File(imgFile.path));
      await uploadTask.whenComplete(() => ref.getDownloadURL().then((value) => imgUrl = value));
      tCollection.doc(tDoc.id).update({'tid': tDoc.id, 'photo': imgUrl});
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> updateTemplate(Templates templates, PickedFile imgFile, String id, String photo) async {
    bool result = true;
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    await tCollection.doc(id).update({
      'tid': id,
      'name': templates.name,
      'desc': templates.desc,
      'price': templates.price,
      'photo': photo,
      'updatedAt': dateNow
    }).then((value) {
      result = true;
    }).catchError((onError) {
      result = false;
    });
    if (imgFile != null) {
      ref = FirebaseStorage.instance.ref().child("TemplatePhotos").child(id + "jpg");
      uploadTask = ref.putFile(File(imgFile.path));
      await uploadTask.whenComplete(() => ref.getDownloadURL().then((value) => imgUrl = value));
      await tCollection.doc(id).update({'photo': imgUrl});
    }
    return result;
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