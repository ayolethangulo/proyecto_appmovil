import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PromotionsPage extends StatefulWidget {
  PromotionsPage({Key? key}) : super(key: key);

  @override
  State<PromotionsPage> createState() => _promotionsPageState();
}

class _promotionsPageState extends State<PromotionsPage> {
  List<String> imagenes = [
    'https://www.alqueria.com.co/sites/default/files/styles/1327_612/public/hamburguesa-con-amigos-y-salsa-de-champinones_0.jpg?h=2dfa7a18&itok=hLxehdIa',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnh407duvp2focHjxaI2WP0MNVzS4eHjf6RRckn1pN8KxUydnQYxXnXfKU5GBM1jIkIhs&usqp=CAU',
    'https://www.clarin.com/img/2021/06/17/LC25eDtCT_1200x630__1.jpg'
  ];
  List<String> imagenes2 = [
    'https://www.comedera.com/wp-content/uploads/2021/07/salchipapas.jpg',
    'https://www.cardamomo.news/__export/1610225590581/sites/debate/img/2021/01/09/botana_con_salchichas_fxcil_y_rxpida_las_salchipapas_crop1610224808939.jpeg_242310155.jpeg'
  ];
  List<String> imagenes3 = [
    'https://images-gmi-pmc.edge-generalmills.com/f5a517df-12c8-4d55-aa70-c882d99122e0.jpg',
    'https://images-gmi-pmc.edge-generalmills.com/f1c75fdc-b10d-4b92-9c60-31d49afaa31f.jpg5'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 110,
          crossAxisSpacing: 10,
          padding: EdgeInsets.all(15),
          children: <Widget>[
            _promotion('Hamburguesa Salvaja', '5 % Dto.', '+5 Calificaciones',
                imagenes),
            _promotion(
                'Hamburguesa gourmet', '5 % Dto.', '+3 compras', imagenes),
          ],
        ),
      ),
    );
  }

  Widget _promotion(String nombreProducto, String beneficio, String condicion,
      List<String> imagen) {
    return ListTile(
      title: _swiperImages(imagen),
      subtitle: InkWell(
        child: Container(
          child: Column(
            children: [
              Text(
                nombreProducto,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline),
              ),
              Text(
                beneficio,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline),
              ),
              Text(
                condicion,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }

  Widget _swiperImages(List<String> images) {
    int longitud = images.length;
    return Container(
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.5,
        autoplay: true,
        duration: 300,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            images[index],
            fit: BoxFit.cover,
          );
        },
        itemCount: longitud,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        onTap: (index) {},
      ),
    );
  }
}
