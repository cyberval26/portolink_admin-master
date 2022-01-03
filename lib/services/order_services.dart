part of 'services.dart';

class OrderServices{
  //setup cloud firestore
   static FirebaseAuth auth = FirebaseAuth.instance;
   static CollectionReference orderCollection = FirebaseFirestore.instance.collection("Order");
   static DocumentReference orderDocument;
   //setup storage
   static Reference ref;
   static UploadTask uploadTask;
   static String imgUrl;
   static Future<bool> approvedOrder( String id) async {
    bool result = true;
    await Firebase.initializeApp();
    await orderCollection.doc(id).update({
      'status' : "finished",
    }).then((value) {
      result = true;
    }).catchError((onError){
      result = false;
    });
    return result;
  }
  static Future<bool> deleteOrder(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await orderCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }
}