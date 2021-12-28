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
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            templates.name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
            maxLines: 1,
            softWrap: true
          ),
          subtitle: Text(
            ActivityServices.toIDR(templates.price),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal
            ),
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
                                Text(
                                  templates.name,
                                  style: const TextStyle(
                                    fontSize: 50
                                  )
                                ),
                                const SizedBox(height: 48),
                                Text("Description : " + templates.desc),
                                const SizedBox(height: 24),
                                Text("Price: " + templates.price),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  icon: const Icon(CupertinoIcons.trash_fill),
                                  label: const Text("Delete Data"),
                                  onPressed: () async {
                                    bool result = await TemplateServices.deleteTemplate(templates.tid);
                                    if (result) {
                                      ActivityServices.showToastBlack(
                                        "Delete Success",
                                        Colors.green
                                      );
                                    } else {
                                      ActivityServices.showToastWhite("Delete Failed", Colors.red);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red
                                  )
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