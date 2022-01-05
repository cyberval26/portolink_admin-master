part of 'widgets.dart';

class TemplateView extends StatefulWidget {
  const TemplateView({Key key, this.templates}) : super(key: key);
  final Templates templates;
  @override
  _TemplateViewState createState() => _TemplateViewState();
}
class _TemplateViewState extends State<TemplateView> {
  @override
  Widget build(BuildContext context) {
    Templates templates = widget.templates;
    return Card(
      color: Colors.blue[100],
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(templates.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            maxLines: 1,
            softWrap: true
          ),
          subtitle: Text(ActivityServices.toIDR(templates.price),
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
                                const SizedBox(height: 24),
                                Image.network(templates.photo),
                                const SizedBox(height: 18),
                                SizedBox(
                                  width: 500,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      templates.name,
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                                    )
                                  )
                                ),
                                const SizedBox(height: 12),
                                Text(ActivityServices.toIDR(templates.price),
                                style: const  TextStyle(fontSize: 18)),
                                const SizedBox(height: 24),
                                Text(templates.desc, style: const TextStyle(fontSize: 18)),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton.icon(
                                          icon: const Icon(CupertinoIcons.pencil),
                                          label: const Text("Update Data"),
                                          onPressed: () {
                                            Navigator.push(
                                              context, MaterialPageRoute(
                                                builder: (context) => EditTemplate(
                                                  tid: templates.tid,
                                                  name: templates.name,
                                                  desc: templates.desc,
                                                  price: templates.price,
                                                  photo: templates.photo
                                                )
                                              )
                                            );
                                          }
                                        )
                                      )
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton.icon(
                                          icon: const Icon( CupertinoIcons.trash_fill),
                                          label: const Text("Delete Data"),
                                          onPressed: () async {
                                            bool result = await TemplateServices.deleteTemplate(templates.tid);
                                            if (result) {
                                              ActivityServices.showToast("Delete Success", Colors.grey);
                                            } else {
                                              ActivityServices.showToast("Delete Failed", Colors.red);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(primary: Colors.red)
                                        )
                                      )
                                    )
                                  ]
                                ),
                                const SizedBox(height: 24),
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