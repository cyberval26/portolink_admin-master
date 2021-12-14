part of 'pages.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: ListView(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: ctrlName,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                labelText: "Name",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder()),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill the field";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
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
                            },
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
                                  child: Icon(isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value.length < 6
                                  ? "Password must have at least 6 characters!"
                                  : null;
                            },
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                //melanjutkan ke tahap berikutnya
                                setState(() {
                                  isLoading = true;
                                });
                                Admins admins = Admins("", ctrlName.text,
                                    ctrlEmail.text, ctrlPassword.text, "", "");
                                String msg = await AuthServices.signUp(admins);
                                // await AuthServices.signUp(users).then((value) {
                                if (msg == "success") {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ActivityServices.showToast(
                                      "Register Success", Colors.green);
                                  Navigator.pushNamed(context, LoginForm.routeName);
                                } else {
                                  ActivityServices.showToast(msg, Colors.red);
                                  // Navigator.pushNamed(context, Login.routeName);
                                }
                                // });
                              } else {
                                //kosongkan aja
                                Fluttertoast.showToast(
                                    msg: "Please check the fields!",
                                    backgroundColor: Colors.red);
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Register"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black, elevation: 4),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginForm.routeName);
                            },
                            child: const Text(
                              "Already registered? Login.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}