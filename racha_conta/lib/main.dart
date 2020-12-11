import 'dart:core';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tValor = TextEditingController();
  final _tQuantidade = TextEditingController();
  final _tGarcom = TextEditingController();

  var _infoText = "Informe seus dados!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tValor.text = "";
    _tQuantidade.text = "";
    _tGarcom.text = "";


    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Numero de pessoas ",_tQuantidade ),
              _editText("Percentual do garçom", _tGarcom),
              _editText("Valor da conta",_tValor),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.deepPurple,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR O VALOR DA CONTA
  void _calculate(){
    setState(() {
      double valor = double.parse(_tValor.text);
      double quantidade = double.parse(_tQuantidade.text);
      double percentual = double.parse(_tGarcom.text)/100;
      double pGarcom = (valor*percentual); double pTotal = valor + pGarcom ;
      double pIndividual = pTotal/quantidade;

      String pTotalStr = pTotal.toStringAsPrecision(5);
      String pGarcomStr = pGarcom.toStringAsPrecision(5);
      String pIndividualStr = pIndividual.toStringAsPrecision(4);
      String valorlStr = valor.toStringAsPrecision(4);

      _infoText = "Valor total consumido (R\$$valorlStr)\nTotal da parte garçom (R\$$pGarcomStr)\nTotal para cada pessoa (R\$$pIndividualStr)\n\nValor total á pagar (R\$$pTotalStr)";


    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 23.0),
    );
  }
}
