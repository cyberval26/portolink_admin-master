part of 'pages.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: ctrlEmail.text,
              password: ctrlPassword.text);

      userCredential.user.updateDisplayName("admin");

      ctrlEmail.text = "";
      ctrlPassword.text = "";
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: ctrlEmail,
            autocorrect: false,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: ctrlPassword,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          ElevatedButton(onPressed: register, child: const Text("Register"))
        ],
      ),
    );
  }
}
