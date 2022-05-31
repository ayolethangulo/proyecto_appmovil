import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/home_pages/Promotions.dart';
import 'package:parcial_1_app_movil/home_pages/bookings.dart';
import 'package:parcial_1_app_movil/home_pages/home.dart';

class ViewMain extends StatefulWidget {
  ViewMain({Key? key}) : super(key: key);

  @override
  State<ViewMain> createState() => _ViewMainState();
}

class _ViewMainState extends State<ViewMain> {
  late int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Nombre de Usuario'),
              accountEmail: Text('ejemplo@gmail.com'),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Image.asset(
                    'image/rest.png',
                    height: 100,
                  )),
              decoration: BoxDecoration(color: Colors.red[700]),
            ),
            ListTile(
              title: Text(
                'Inicio',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Configuracion de la cuenta',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Ayuda',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.help_outline),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Raiting Restaurant',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'cursive',
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Icon(Icons.contact_support_outlined),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.red[700],
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigationBottom,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red[100],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_fix_high_outlined), label: 'Promociones'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_outlined), label: 'reservar'),
        ],
      ),
    );
  }

  _navigationBottom(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    HomePage(),
    PromotionsPage(),
    BookingsPage(),
  ];
}
