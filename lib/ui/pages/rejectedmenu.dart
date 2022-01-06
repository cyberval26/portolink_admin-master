part of 'pages.dart';

class RejectedMenu extends StatefulWidget {
  const RejectedMenu({Key key, this.orderId, this.pendingBy}) : super(key: key);
  final String orderId;
  final String pendingBy;
  @override
  _RejectedMenuState createState() => _RejectedMenuState();
}
class _RejectedMenuState extends State<RejectedMenu> {
  String args;
  final _formKey = GlobalKey<FormState>();
  final ctrlReason = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    ctrlReason.dispose();
    super.dispose();
  }
  void clearForm() {
    ctrlReason.clear();
  }
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text("Rejected Menu")),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: ctrlReason,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Reason",
                            prefixIcon: Icon(Icons.message),
                            border: OutlineInputBorder()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          }
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              bool result = await PendingServices.rejectedPending(ctrlReason.text, widget.pendingBy);
                              await OrderServices.deleteOrder(widget.orderId);
                              if (result) {
                                ActivityServices.showToast("Reject Success", Colors.grey);
                                clearForm();
                                Navigator.pushReplacementNamed(context, Home.routeName);
                                setState(() {
                                    isLoading = false;
                                });
                              } else {
                                ActivityServices.showToast("Reject Failed", Colors.red);
                              }
                            } else {
                                ActivityServices.showToast("Please check all the fields", Colors.red);
                            }
                          },
                          icon: const Icon(Icons.send),
                          label: const Text("Send Reason"),
                          style: ElevatedButton.styleFrom(primary: Colors.green, elevation: 4)
                        )
                      ]
                    )
                  )
                )
              ]
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