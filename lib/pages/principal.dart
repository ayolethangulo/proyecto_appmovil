import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/modelo/modelos.dart';
import 'package:parcial_1_app_movil/pages/modificar.dart';

import 'adicionar.dart';

class Principal extends StatefulWidget {
  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List _listaempleado = empleado;
  List _listaregistro = registro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista Empleados'),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.all(1.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Text('Admin'),
                ))
          ],
        ),
        body: ListView.builder(
            itemCount: _listaempleado.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ModificarEmpleado(_listaempleado[index])))
                      .then((newEmpleado) {
                    if (newEmpleado != null) {
                      setState(() {
                        _listaempleado.removeAt(index);
                        _listaempleado.insertAll(index, newEmpleado);
                      });
                    }
                  });
                },
                onLongPress: () {
                  _eliminarempleado(context, _listaempleado[index]);
                },
                title: Text(_listaempleado[index].nombre +
                    ' ' +
                    _listaempleado[index].apellido),
                subtitle:
                    Text('Profesion : ' + _listaempleado[index].profesion),
                leading: Container(
                    padding: EdgeInsets.all(1.0),
                    width: 50.0,
                    height: 50.0,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(_listaempleado[index].foto),
                    )),
                trailing: CircleAvatar(
                    backgroundColor: Colors.pink[600],
                    radius: 15,
                    child: Text(_listaempleado[index].edad)),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdicionarEmpleado(), //Llamar la Vista Adicionar
              ),
            ).then((resultado) {
              _listaempleado.addAll(resultado);
              setState(() {});
            });
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.black12);
  }

  _eliminarempleado(context, Empleado empleadoid) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Eliminar Empleado'),
              content: Text('Esta Seguro de Eliminar a: ' + empleadoid.nombre),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      this._listaempleado.remove(empleadoid);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}
