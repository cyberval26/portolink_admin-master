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
    if (requests == null) {
      return Container();
    }
    return Card(
      color: Colors.blue[100],
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: Container(padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(requests.templateName.toUpperCase(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            maxLines: 1,
            softWrap: true
          ),
          subtitle: Text("Date : " + requests.createdAt, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 48),
                                    FadeInImage(
                                      placeholder: NetworkImage(requests.photoReference),
                                      image: NetworkImage(requests.photoReference),
                                      imageErrorBuilder: (ctx, exception, stackTrace) {
                                        return Container();
                                      }
                                    ),
                                    const SizedBox(height: 24),
                                    const Text('Link Photo Reference', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0,color: Colors.black)),
                                    const SizedBox(height: 1),
                                    SelectableText(requests.photoReference),
                                    const SizedBox(height: 24),
                                    const Text('Date', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                    const SizedBox(height: 1),
                                    Text(requests.createdAt),
                                    const SizedBox(height: 24),
                                    const Text('Item Name', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                    const SizedBox(height: 1),
                                    Text(requests.templateName),
                                    const SizedBox(height: 24),
                                    const Text('Color',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                    const SizedBox(height: 1),
                                    Text(requests.color),
                                    const SizedBox(height: 24),
                                    const Text('Contact', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                    const SizedBox(height: 1),
                                    Text(requests.contact),
                                    const SizedBox(height: 24),
                                    const Text('Request Description', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                    const SizedBox(height: 1),
                                    Text(requests.requestDescription)
                                  ]
                                ),
                                const SizedBox(height: 24)
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
                                  icon: const Icon( CupertinoIcons.clear),
                                  label: const Text("Reject"),
                                  onPressed: () async {
                                    Navigator.push(
                                      context, MaterialPageRoute(
                                        builder: (context) => RejectedMenu(orderId: requests.orderId, pendingBy: requests.pendingBy)
                                      )
                                    );
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
                                    Navigator.push(
                                      context, MaterialPageRoute(
                                        builder: (context) =>
                                          ApprovedMenu(orderId: requests.orderId, pendingBy: requests.pendingBy)
                                      )
                                    );
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