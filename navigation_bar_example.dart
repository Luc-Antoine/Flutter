class NavigationBarController extends StatefulWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  final NavigationBarView _navigationBarView = NavigationBarView();
  final AppColor appColor = AppColor();

  NavigationBarView createState() => _navigationBarView;

  InscriptionController instantiateInscriptionController() {
    return InscriptionController(this, this.appColor);
  }
}

class NavigationBarView extends State<NavigationBarController> {
  List<Widget> currentWidget = List<Widget>();
  int _selectedIndex = 0;

  final AppColor appColor = AppColor();
  AppDatabase appDatabase;
  List<Object> _objects = List<Object>();

  ObjectDao objectDao;
  int indexView;

  InscriptionController inscriptionController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentWidget.length == 0) {
      _initDataBase();
    }
    return _scaffold();
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.mobile_friendly),
          label: 'Objets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Compte',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  Scaffold _scaffold() {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body() {
    return currentWidget[_selectedIndex];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<int> _initDataBase() async {
    appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    objectDao = appDatabase.objectDao;
    _objects = await objectDao.findAll();
    _initCurrentWidget();
    return _objects.length;
  }

  void _initCurrentWidget() {
    inscriptionController = widget.instantiateInscriptionController();

    currentWidget.add(
        Container(
          color: Colors.blue,
        )
    );
    currentWidget.add(inscriptionController);
  }
}