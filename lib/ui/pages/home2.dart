part of 'pages.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static const String routeName = "/Home";  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int _selectedIntex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Catalog(),
    Requests(),
    const Profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIntex = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIntex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Catalog'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Requests'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Profile'
          ),
        ],
        currentIndex: _selectedIntex,
        onTap: _onItemTapped,
        elevation: 0
      ),
    );
  }
}