part of 'widgets.dart';

class TemplateCard extends StatefulWidget {
  final Templates templates;
  // ignore_for_file: prefer_const_constructors_in_immutables
  // ignore: use_key_in_widget_constructors
  TemplateCard({this.templates});
  @override
  _TemplateCardState createState() => _TemplateCardState();
}
class _TemplateCardState extends State<TemplateCard> {
  @override
  Widget build(BuildContext context) {
    Templates templates = widget.templates;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(templates.tPhoto)
          ),
          title: Text(
            templates.tName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold),
              maxLines: 1,
              softWrap: true
          ),
          subtitle: Text(
            ActivityServices.toIDR(templates.tPrice),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal),
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
                        child : ListView(
                          children: [
                            Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(templates.tName, 
                              style: const TextStyle(
                                fontSize: 50)
                            ),
                            const SizedBox(
                              height: 24
                            ),
                            Image.network(templates.tPhoto),
                            const SizedBox(
                              height: 48
                            ),
                            Text("Description : " + templates.tDesc),
                            const SizedBox(
                              height: 24
                            ),
                            Text("Price: " + templates.tPrice),
                            const SizedBox(
                              height: 24
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(CupertinoIcons.trash_fill),
                              label: const Text("Delete Data"),
                              onPressed: () async {
                                bool result = await TemplateServices.deleteTemplate(templates.tId);
                                if(result){
                                  ActivityServices.showToast("Delete Success", Colors.green);
                                } else {
                                  ActivityServices.showToast("Delete Failed", Colors.red);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red
                              ),
                            ),
                          ],
                        ),
                          ],
                        )
                      );
                    }
                  );
                },
              ),
            ],
          )
        )
      )
    );
  }
}