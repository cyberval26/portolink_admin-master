part of 'widgets.dart';

class ApprovedView extends StatefulWidget {
  const ApprovedView({Key key, this.requests}) : super(key: key);
  final Requests requests;
  @override
  _ApprovedViewState createState() => _ApprovedViewState();
}
class _ApprovedViewState extends State<ApprovedView> {
  @override
  Widget build(BuildContext context) {
    Requests requests = widget.requests;
    if(requests == null){
      Container();
    }else {
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
                      ]
                  )
              )
          )
      );
      /*return Card(
          color: Colors.blue[100],
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(8),
          child: Container(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                  title: Text(
                      requests.templateName,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      softWrap: true
                  ),
                  subtitle: Text(
                      requests.contact,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                      maxLines: 1,
                      softWrap: true
                  ),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: const Icon(CupertinoIcons.ellipsis_circle_fill),
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
                                                    Text(requests.templateName, style: const TextStyle(fontSize: 50)),
                                                    const SizedBox(height: 48),
                                                    Image.network(requests.photoReference),
                                                    const SizedBox(height: 48),
                                                    ElevatedButton.icon(
                                                        icon: const Icon(CupertinoIcons.pencil),
                                                        label: const Text("Update Data"),
                                                        onPressed: () {
                                                          /*Navigator.push(context, MaterialPageRoute(
                                                              builder: (context) => EditTemplate(
                                                                  tid: templates.tid,
                                                                  name:templates.name,
                                                                  desc: templates.desc,
                                                                  price:templates.price,
                                                                  photo: templates.photo
                                                              )
                                                          ));*/
                                                        }
                                                    ),
                                                    const SizedBox(height: 24),
                                                    ElevatedButton.icon(
                                                        icon: const Icon(CupertinoIcons.trash_fill),
                                                        label: const Text("Delete Data"),
                                                       /* onPressed: () async {
                                                          bool result = await TemplateServices.deleteTemplate(templates.tid);
                                                          if (result) {
                                                            ActivityServices.showToastWhite("Delete Success");
                                                          } else {
                                                            ActivityServices.showToastBlack("Delete Failed");
                                                          }
                                                        },*/
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
                        )
                      ]
                  )
              )
          )
      );*/
    }
  }
}