import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _EntradaCep = TextEditingController();

  String _resultado = "Resultado";

  //Comunicação síncrona e assincrona
  _recuperarCep() async {

    String cep = _EntradaCep.text;
    String url ="https://viacep.com.br/ws/${cep}/json/";

    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });

    print(
      "Resposta logradouro: ${logradouro} complemento: ${complemento} bairro: ${bairro} localidade: ${localidade} "
    );

    _EntradaCep.text = "";

    //print("resposta: " + response.statusCode.toString());
   //print("resposta: " + response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
            labelText: ("Digite um cep"),

             ),
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _EntradaCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
