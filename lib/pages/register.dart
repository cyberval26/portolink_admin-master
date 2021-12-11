part of 'pages.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();

  register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: textEmailController.text,
              password: textPasswordController.text);

      userCredential.user!.updateDisplayName("admin");

      textEmailController.text = "";
      textPasswordController.text = "";
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
            controller: textEmailController,
            autocorrect: false,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: textPasswordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          ElevatedButton(onPressed: register, child: const Text("Register"))
        ],
      ),
    );
  }
}
