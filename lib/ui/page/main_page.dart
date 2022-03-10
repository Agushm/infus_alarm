// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MonitoringPage(),
    CalculatorPage(),
    // NotificationPage(null),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons
                .alarm), //Image.asset(iconsPath + 'house.png', width: 20, height: 20),
            label: 'Jam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .desktop_mac), //Image.asset(iconsPath + 'completed-task.png', width: 20, height: 20),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .calculate), //Image.asset(iconsPath + 'completed-task.png', width: 20, height: 20),
            label: 'Kalkulator',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons
          //       .notifications), //Image.asset(iconsPath + 'completed-task.png', width: 20, height: 20),
          //   label: 'Notification',
          // ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
