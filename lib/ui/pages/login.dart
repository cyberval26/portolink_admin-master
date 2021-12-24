part of 'pages.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);
  static const String routeName = "/login";
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  // login() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //             email: textEmailController.text,
  //             password: textPasswordController.text);
  //     print("login success for " + FirebaseAuth.instance.currentUser.email);
  //     //print(FirebaseAuth.instance.currentUser!.displayName!);
  //     if (FirebaseAuth.instance.currentUser.displayName == null) {
  //       print('user is not an admin');
  //       FirebaseAuth.instance.signOut();
  //     }
  //     // Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {}
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
              Align(
                  alignment: const AlignmentDirectional(0, -0.8),
                  child: Image.asset('assets/images/portolink.png',
                      width: 250, height: 250, fit: BoxFit.fill)),
              Container(
                  padding: const EdgeInsets.all(32),
                  child: ListView(children: [
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          const SizedBox(height: 300),
                          TextFormField(
                              controller: ctrlEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.mail_outline_rounded),
                                  border: OutlineInputBorder()),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please fill the field";
                                } else {
                                  if (!EmailValidator.validate(value)) {
                                    return "Email isn't valid!";
                                  } else {
                                    return null;
                                  }
                                }
                              }),
                          const SizedBox(height: 24),
                          TextFormField(
                              controller: ctrlPassword,
                              obscureText: isVisible,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: const Icon(Icons.vpn_key),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return value.isEmpty
                                    ? "Password must have at least 1 characters!"
                                    : null;
                              }),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String msg = await AuthServices.signIn(
                                      ctrlEmail.text, ctrlPassword.text);
                                  if (msg == "Success") {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToastBlack(
                                        "Login Success", Colors.grey[200]);
                                    // Navigator.pushReplacementNamed(
                                    //    context, Home.routeName
                                    // );
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToastBlack(
                                        msg, Colors.grey[200]);
                                  }
                                  Fluttertoast.showToast(
                                      msg: "Please check the fields!",
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white);
                                }
                              },
                              icon: const Icon(Icons.login_rounded),
                              label: const Text("Login"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black, elevation: 4)),
                          const SizedBox(height: 24),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Register.routeName);
                              },
                              child: const Text("Not registered yet? Join Now.",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16)))
                        ]))
                  ])),
              isLoading == true ? ActivityServices.loadings() : Container()
            ])));
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   title: const Text("Login"),
  //     // ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: textEmailController,
  //             autocorrect: false,
  //             decoration: const InputDecoration(labelText: "Email"),
  //           ),
  //           TextField(
  //             controller: textPasswordController,
  //             obscureText: true,
  //             decoration: const InputDecoration(labelText: "Password"),
  //           ),
  //           ElevatedButton(onPressed: login, child: const Text("Login")),
  //           ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pushNamed(context, '/register');
  //               },
  //               child: const Text("Register")),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
