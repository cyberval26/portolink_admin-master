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
                        const SizedBox(height: 300),
                        TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            border: OutlineInputBorder()
                          ),
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
                            prefixIcon: const Icon(Icons.lock),
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
                              )
                            )
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value.length < 6
                            ? "Password must have at least 6 characters!"
                            : null;
                          }
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              String msg = await AuthServices.signIn(
                                ctrlEmail.text,
                                ctrlPassword.text
                              );
                              if (msg == "Success") {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast("Login Success", Colors.grey);
                                Navigator.pushReplacementNamed(context, Home.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast("Login Failed", Colors.red);
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please check all the fields",
                                backgroundColor: Colors.red,
                                textColor: Colors.white
                              );
                            }
                          },
                          icon: const Icon(Icons.login_rounded),
                          label: const Text("Login"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 4
                          )
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context, Register.routeName);
                          },
                          child: const Text(
                            "Not registered yet? Join Now.",
                            style: TextStyle(
                              color: Colors.red, fontSize: 16
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
}