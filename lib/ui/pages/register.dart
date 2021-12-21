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
  // register() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: ctrlEmail.text,
  //             password: ctrlPassword.text);
  //     userCredential.user.updateDisplayName("admin");
  //     ctrlEmail.text = "";
  //     ctrlPassword.text = "";
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
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
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, -0.8),
              child: Image.asset(
                'assets/images/portolink.png',
                width: 250,
                height: 250,
                fit: BoxFit.fill
              )
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 300,
                        ),
                        TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            border: OutlineInputBorder()),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            }
                          ),
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
                              child: Icon(
                                isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off
                              ))
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value.isEmpty
                                  ? "Password must have at least 1 character!"
                                  : null;
                            }
                          ),
                          const SizedBox(
                            height: 24
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                Admins admins = Admins("", ctrlEmail.text, ctrlPassword.text, "", "");
                                String msg = await AuthServices.signUp(admins);
                                if (msg == "Success") {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ActivityServices.showToastBlack(
                                    "Register Success", Colors.grey[200]
                                  );
                                  Navigator.pushReplacementNamed(
                                    context, LoginForm.routeName
                                  );
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ActivityServices.showToastWhite(msg, Colors.red);
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please check the fields!",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white
                                );
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Register"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              elevation: 4
                            )
                          ),
                          const SizedBox(
                            height: 24
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context, LoginForm.routeName
                              );
                            },
                            child: const Text(
                              "Already registered? Login.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16
                              )
                            )
                          )
                      ]
                    )
                  )
                ]
              )
            ),
            isLoading == true
              ? ActivityServices.loadings()
              : Container()
          ]
        )
      )
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Register"),
  //     ),
  //     body: Column(
  //       children: [
  //         TextField(
  //           controller: ctrlEmail,
  //           autocorrect: false,
  //           decoration: const InputDecoration(labelText: "Email"),
  //         ),
  //         TextField(
  //           controller: ctrlPassword,
  //           obscureText: true,
  //           decoration: const InputDecoration(labelText: "Password"),
  //         ),
  //         ElevatedButton(onPressed: register, child: const Text("Register"))
  //       ],
  //     ),
  //   );
  // }
}