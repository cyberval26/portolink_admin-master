part of 'services.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference admCollection = FirebaseFirestore.instance.collection("Admins");
  static DocumentReference admDoc;
  static Future<String> signUp(Admins admins) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String token;
    String uid;
    String msg;
    UserCredential admCredential = await auth.createUserWithEmailAndPassword(email: admins.email, password: admins.pass);
    uid = admCredential.user.uid;
    token = await FirebaseMessaging.instance.getToken();
    await admCollection.doc(uid).set({
      'uid': uid,
      'name': admins.name,
      'email': admins.email,
      'pass': admins.pass,
      'token': token,
      'createdAt': dateNow,
      'updatedAt': dateNow
    }).then((value) {
      msg = "Success";
    }).catchError((onError) {
      msg = onError;
    });
    auth.signOut();
    return msg;
  }
  static Future<String> signIn(String email, String password) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid;
    String msg;
    String token;
    UserCredential admCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    uid = admCredential.user.uid;
    token = await FirebaseMessaging.instance.getToken();
    await admCollection.doc(uid).update({
      'isOn': '1',
      'token': token,
      'updatedAt': dateNow
    }).then((value) {
      msg = "Success";
    }).catchError((onError) {
      msg = onError;
    });
    return msg;
  }
  static Future<bool> signOut() async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    await auth.signOut().whenComplete(() {
      admCollection.doc(uid).update({
        'isOn': '0',
        'token': '-',
        'updatedAt': dateNow
      });
    });
    return true;
  }
}