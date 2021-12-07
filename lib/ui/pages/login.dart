part of '../main.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();
  login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: textEmailController.text,
              password: textPasswordController.text);
      print("login success for " + FirebaseAuth.instance.currentUser!.email!);
      //print(FirebaseAuth.instance.currentUser!.displayName!);
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        print('user is not an admin');
        FirebaseAuth.instance.signOut();
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: textEmailController,
              autocorrect: false,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: textPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(onPressed: login, child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
