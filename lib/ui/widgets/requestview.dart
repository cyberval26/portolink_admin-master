part of 'widgets.dart';

class RequestView extends StatefulWidget {
  const RequestView({Key key, this.requests}) : super(key: key);
  final Requests requests;
  @override
  _RequestViewState createState() => _RequestViewState();
}
class _RequestViewState extends State<RequestView> {
  @override
  Widget build(BuildContext context) {
    Requests requests = widget.requests;
    return Card(
      color: Colors.blue[100],
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            requests.templateName.toUpperCase(),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            maxLines: 1,
            softWrap: true
          ),
          subtitle: Text(
            "Color : " + requests.color,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            maxLines: 1,
            softWrap: true
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.blue,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext ctx) {
                      return Container(
                        padding: const EdgeInsets.all(32),
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Contact : " + requests.contact, style: const TextStyle(fontSize: 20)),
                                const SizedBox(height: 48),
                                Image.network(requests.photoReference),
                                const SizedBox(height: 24),
                                Text("Description : " + requests.requestDescription),
                                const SizedBox(height: 24),
                              ]
                            )
                          ]
                        )
                      );
                    }
                  );
                }
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                color: Colors.blue,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext ctx) {
                      return Container(
                        padding: const EdgeInsets.all(32),
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  icon: const Icon(CupertinoIcons.clear),
                                  label: const Text("Reject"),
                                  onPressed: () async {
                                    bool result = await TemplateServices.deleteTemplate(requests.orderId);
                                    if (result) {
                                      ActivityServices.showToastWhite("Success");
                                    } else {
                                      ActivityServices.showToastBlack("Failed");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(primary: Colors.red)
                                )
                              ]
                            )
                          ]
                        )
                      );
                    }
                  );
                }
              ),
              IconButton(
                icon: const Icon(Icons.done),
                color: Colors.blue,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext ctx) {
                      return Container(
                        padding: const EdgeInsets.all(32),
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.done),
                                  label: const Text("Accept"),
                                  onPressed: () async {
                                    bool result = await TemplateServices.deleteTemplate(requests.orderId);
                                    if (result) {
                                      ActivityServices.showToastWhite("Success");
                                    } else {
                                      ActivityServices.showToastBlack("Failed");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(primary: Colors.green)
                                )
                              ]
                            )
                          ]
                        )
                      );
                    }
                  );
                }
              )
            ]
          )
        )
      )
    );
  }
}