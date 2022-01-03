part of 'services.dart';

class OrderServices{
  //setup cloud firestore
   static FirebaseAuth auth = FirebaseAuth.instance;
   static CollectionReference orderCollection = FirebaseFirestore.instance.collection("order");
  // static CollectionReference pinsCollection = FirebaseFirestore.instance.collection("pins");
   static DocumentReference orderDocument;

   //setup storage
   static Reference ref;
   static UploadTask uploadTask;
   static String imgUrl;

   /*static Future<bool> addOrder(Order order, PickedFile imgFile) async{
      String dateNow = ActivityServices.dateNow();
      await Firebase.initializeApp();
      orderDocument = await orderCollection.add({
         'orderId' : order.orderId,
         'templateName' : order.templateName,
         'color' : order.color,
         'contact' : order.contact,
         'requestDescription' : order.requestDescription,
         'photoReference' : order.photoReference,
         'addBy':auth.currentUser.uid,
         'createdAt' : dateNow,
      });
      if(orderDocument != null){
        /* ref = FirebaseStorage.instance.ref().child("images").child(orderDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );*/

         orderCollection.doc(orderDocument.id).update(
            {
               'orderId' : orderDocument.id,
            }
         );

         return true;
      }else{
         return false;
      }
   }*/


   static Future<bool> approvedOrder( String id) async {
      bool result = true;
      await Firebase.initializeApp();
      String dateNow = ActivityServices.dateNow();
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
      bool hsp = true;
      await Firebase.initializeApp();
      await orderCollection.doc(id).delete().then((value) {
         hsl = true;
      }).catchError((onError){
         hsl = false;
      });

      return hsl;
   }



   /*static Future<bool> updateproduct(Assignment assignment,PickedFile imgFile, String id) async {
      bool hsl = true;
      await Firebase.initializeApp();
      await assignmentCollection.doc(id).update({
         'assignId' : assignment.assignId,
         'assignName' : assignment.assignName,
         'assignCourse' : assignment.assignCourse,
         'assignDeadline' : assignment.assignDeadline,
         'assignDesc' : assignment.assignDesc,
         'updatedAt' : assignment.updateAt,

      }).then((value) {
         hsl = true;
      }).catchError((onError){
         hsl = false;
      });
      if(imgFile != null) {
         ref = FirebaseStorage.instance.ref().child("images").child(id + "jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(() =>
             ref.getDownloadURL().then((value) => imgUrl = value,)
         );

         await assignmentCollection.doc(id).update(
             {
                'assignImage': imgUrl,
             }
         );
      }

      return hsl;
   }*/

}