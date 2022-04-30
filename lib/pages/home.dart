import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/bike.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bike> bikes = [
    Bike(id: '1', name: 'Giant XTR', type: 10),
    Bike(id: '2', name: 'Scott', type: 2),
    Bike(id: '3', name: 'Cannondale', type: 1),
    Bike(id: '4', name: 'Berria', type: 3),
    Bike(id: '5', name: 'BH2', type: 13),
  ];

  get itemBuilder => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bikes', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        leading: Icon(Icons.pedal_bike),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bikes.length,
          itemBuilder: (context, i) => _bikeTile(bikes[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bikeTile(Bike bike) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(bike.id),
      onDismissed: (direction) {
        print('direccion : $direction');
        print('bike : ${bike.id}');
        //TODO: llamas el borrado
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Bike',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: _bikeCard(bike), //_botonesRedondeados(bike), //_bikeCard(bike),
    );
  }

  Widget _bikeCard(Bike bike) {
    return ClipRect(
        child: Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(162, 166, 107, 0.7),
          borderRadius: BorderRadius.circular(17.0)),
      margin: EdgeInsets.all(10.0),
      child: _bikeCardSummary(bike),
    ));
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Container(
          height: 125.0,
          margin: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 5.0,
              ),
              CircleAvatar(
                backgroundColor: color, //Colors.pinkAccent,
                radius: 35.0,
                child: Icon(icono, color: Colors.white, size: 30.0),
              ),
              Text(
                texto,
                style: TextStyle(color: Colors.pinkAccent),
              ),
              SizedBox(
                height: 5.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonesRedondeados(Bike bike) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.blue, Icons.border_all, ' Reservas'),
          _crearBotonRedondeado(Colors.red, Icons.play_circle_fill, ' Jugar')
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Colors.blue, Icons.collections, ' Mis partidos'),
          _crearBotonRedondeado(
              Colors.green, Icons.accessibility_new_outlined, ' Dummy')
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Colors.pinkAccent, Icons.cloud_done, ' General'),
          _crearBotonRedondeado(Colors.orange, Icons.help_outline, ' General')
        ]),
      ],
    );
  }

  Widget _bikeCardSummary(Bike bike) {
    return ListTile(
      leading: CircleAvatar(
        // child:
        //    _crearBotonRedondeado(Colors.orange, _icon(bike.type), bike.name),
        child: _icon(bike.type),
        //child: Text(bike.name.substring(0, 3)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(bike.name),
      trailing: Text(
        '${bike.type}',
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        print(bike.name);
      },
    );
  }

  Widget _icon(int type) {
    if (type > 5) {
      return Icon(Icons.pedal_bike);
    } else {
      return Icon(Icons.electric_bike);
    }
  }

  addNewBand() {
    final _textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Introduzca nombre'),
            content: TextField(
              controller: _textController,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => addBikeToList(_textController.text),
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Introduzca nombre'),
            content: CupertinoTextField(
              controller: _textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBikeToList(_textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void addBikeToList(String name) {
    if (name.length > 1) {
      // podemos añadir
      this
          .bikes
          .add(new Bike(id: DateTime.now().toString(), name: name, type: 1));
      setState(() {});
    }
    // cerramos el dialog
    Navigator.pop(context);
  }
}
