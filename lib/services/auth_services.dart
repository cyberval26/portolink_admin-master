part of 'services.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference admCollection = FirebaseFirestore.instance.collection("Admins");
  static Future<String> signUp(Admins admins) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String token;
    String aid;
    String msg;
    UserCredential admCredential = await auth.createUserWithEmailAndPassword(email: admins.email, password: admins.pass);
    aid = admCredential.user.uid;
    token = await FirebaseMessaging.instance.getToken();
    await admCollection.doc(aid).set({
      'aid': aid,
      'email': admins.email,
      'pass': sha512.convert(utf8.encode(admins.pass)).toString(),
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
    String aid;
    String msg;
    String token;
    UserCredential admCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    aid = admCredential.user.uid;
    token = await FirebaseMessaging.instance.getToken();
    await admCollection.doc(aid).update({
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
    String aid = auth.currentUser.uid;
    await auth.signOut().whenComplete(() {
      admCollection.doc(aid).update({
        'isOn': '0',
        'token': '-',
        'updatedAt': dateNow
      });
    });
    return true;
  }
}