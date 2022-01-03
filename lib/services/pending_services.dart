part of'services.dart';

class PendingServices{
  //setup cloud firestore
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference pendingCollection = FirebaseFirestore.instance.collection("pending");
  // static CollectionReference pinsCollection = FirebaseFirestore.instance.collection("pins");
  static DocumentReference pendingDocument;

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addPending(Pending pending, PickedFile imgFile) async{
    String dateNow = ActivityServices.dateNow();
    await Firebase.initializeApp();
    pendingDocument = await pendingCollection.add({
      'pendingId' : pending.pendingId,
      'templateName' : pending.templateName,
      'link' : pending.link,
      'color':pending.color,
      'description' : pending.description,
      'status' : "In Progress",
      'addBy':auth.currentUser.uid,
    });
    if(pendingDocument != null){
      /* ref = FirebaseStorage.instance.ref().child("images").child(orderDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );*/

      pendingCollection.doc(pendingDocument.id).update(
          {
            'pendingId' : pendingDocument.id,
          }
      );

      return true;
    }else{
      return false;
    }
  }

  static Future<bool> approvedPending( String id) async {
    bool result = true;
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    await pendingCollection.doc(id).update({
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
    String dateNow = ActivityServices.dateNow();
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