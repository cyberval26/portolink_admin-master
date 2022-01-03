part of'services.dart';

class PendingServices{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference pendingCollection = FirebaseFirestore.instance.collection("Pending");
  static DocumentReference pendingDocument;
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;
  static Future<bool> addPending(Pending pending, PickedFile imgFile) async{
    await Firebase.initializeApp();
    pendingDocument = await pendingCollection.add({
      'pendingId' : pending.pendingId,
      'templateName' : pending.templateName,
      'link' : pending.link,
      'color':pending.color,
      'description' : pending.description,
      'status' : "In Progress",
      'addBy':auth.currentUser.uid
    });
    if(pendingDocument != null){
      pendingCollection.doc(pendingDocument.id).update({
        'pendingId' : pendingDocument.id
      });
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> approvedPending(String link, String id) async {
    bool result = true;
    await Firebase.initializeApp();
    await pendingCollection.doc(id).update({
      'link' : link,
      'status' : "approved",
    }).then((value) {
      result = true;
    }).catchError((onError){
      result = false;
    });
    return result;
  }
  static Future<bool> rejectedPending( String id) async {
    bool result = true;
    await Firebase.initializeApp();
    await pendingCollection.doc(id).update({
      'status' : "rejected",
    }).then((value) {
      result = true;
    }).catchError((onError){
      result = false;
    });
    return result;
  }
}