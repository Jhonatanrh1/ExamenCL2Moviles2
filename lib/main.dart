import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Office Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  String? nombres;
  String? pedidos;
  double? precio;
  double? cantidad;
  double? total = 0;
  double? descuento = 0;
  double? delivery = 0;
  double? totalPagar = 0;
  String? mensaje = "";
  bool? validacion = false;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//Metodos
  final _tfNombres = TextEditingController();
  final _tfPedido = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();

//para el descuento
  double descuento = 0.05;
  double delivery = 20;

  void _CalcularPedido() {
    setState(() {
      widget.validacion = false;
      if (_tfPrecio.text.toString() == "" ||
          _tfCantidad.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "Ingrese datos ";
        return;
      }
      //calculos
      widget.total =
          double.parse(_tfPrecio.text) * double.parse(_tfCantidad.text);

      widget.descuento = double.parse(widget.total.toString()) * descuento;

      widget.totalPagar = double.parse(widget.total.toString()) -
          double.parse(widget.descuento.toString()) +
          delivery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              child: Text(
                  "Bienvenido por favor complete sus datos para completar su pedido."),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(children: <Widget>[
                TextField(
                    controller: _tfNombres,
                    decoration: InputDecoration(
                        hintText: "Ingresa los  nombres",
                        labelText: "Nombres")),
                TextField(
                    controller: _tfPedido,
                    decoration: InputDecoration(
                        hintText: "Ingresa pedido", labelText: "Pedido")),
                TextField(
                    controller: _tfPrecio,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: "Precio",
                      labelText: "Precio",
                      errorText: _tfPrecio.text.toString() == ""
                          ? widget.mensaje
                          : null,
                    )),
                TextField(
                    controller: _tfCantidad,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: "Ingresa la Cantidad",
                      labelText: "Cantidad",
                      errorText: _tfPrecio.text.toString() == ""
                          ? widget.mensaje
                          : null,
                    )),
                Text("Total:" + widget.total.toString()),
                Text("Descuento:" + widget.descuento.toString()),
                Text("Delivery:" + delivery.toString()),
                ElevatedButton(
                  onPressed: _CalcularPedido,
                  child: Text("Calcular"),
                ),
                Text("Total a Pagar:" + widget.totalPagar.toString()),
              ]),
            )
          ],
        ));
  }
}
