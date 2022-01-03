part of "pages.dart";

class ApprovedMenu extends StatefulWidget {
  const ApprovedMenu({Key key, this.orderId, this.pendingBy}) : super(key: key);
  static const String routeName = "/edittemplate";
  final String orderId;
  final String pendingBy;

  @override
  _ApprovedMenuState createState() => _ApprovedMenuState();
}
class _ApprovedMenuState extends State<ApprovedMenu> {
  String args;
  final _formKey = GlobalKey<FormState>();
  final ctrlLink = TextEditingController();
  bool isLoading = false;

 /* @override
  void initState() {
    ctrlName.text = widget.name;
    ctrlDesc.text = widget.desc;
    ctrlPrice.text = widget.price;
    super.initState();
  }*/

  @override
  void dispose() {
    ctrlLink.dispose();
    super.dispose();
  }
  void clearForm() {
    ctrlLink.clear();
  }
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
            title: const Text('Approved Menu'),
            centerTitle: true
        ),
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
                                          controller: ctrlLink,
                                          keyboardType: TextInputType.name,
                                          decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Link",
                                              prefixIcon: Icon(Icons.bookmark),
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
                                              bool result = await PendingServices.approvedPending(ctrlLink.text,widget.pendingBy);
                                              await OrderServices.approvedOrder(widget.orderId);
                                              if (result) {
                                                ActivityServices
                                                    .showToastWhite(
                                                    "Approved Success");
                                                clearForm();
                                                Navigator.pushReplacementNamed(context, Home.routeName);
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } else {
                                                ActivityServices
                                                    .showToastBlack(
                                                    "Failed");
                                              }
                                            } else {
                                              ActivityServices.showToastWhite("Please check all  the fields.");
                                            }
                                          },
                                          icon: const Icon(Icons.upload),
                                          label: const Text("Update Template"),
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