part of 'pages.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static const String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  bool isLoading = false;
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Catalog(),
    const Request(),
    const Approved(),
    const Profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Catalog'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Approved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profiles')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}