import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dataFromApi.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// criar uma lista para puxar os dados da api
Future<dataFromApi> fetchData(String nome) async {
  final response = await http.post(Uri.parse("https://www.slmm.com.br/CTC/insere.php"),
      headers: {"Accept": "application/json"},
      body: {"nome": nome, "data": DateFormat("yy/MM/dd HH:mm:ss").format(DateTime.now())}
      );
  //debugPrint(response.body);
  debugPrint(response.statusCode.toString());
  debugPrint(response.body.toString());
  debugPrint(DateFormat("yy/MM/dd HH:mm:ss").format(DateTime.now()));

  if (response.statusCode == 200) {
    return dataFromApi.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erro inesperado....');
  }
  //rrdebugPrint(response.toString());
}

class Insere extends StatefulWidget {
  const Insere({Key? key}) : super(key: key);

  @override
  State<Insere> createState() => _InsereState();
}

class _InsereState extends State<Insere> {
  // criar aqui
  late Future<List<dataFromApi>> futureData;
  Future<dataFromApi>? _futureData2;
  final TextEditingController _controller = TextEditingController();
/*
  final String text;
  _InsereState({this.text = "test"});

final controller =  TextEditingController(text: text) ;

  @override
    void initState() {
        controller =  TextEditingController(text: widget.text) ;
        super.initState();
      }
      late final controller;
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inseregem"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.person),
                    hintText: 'Informe o nome'),
                    controller: _controller,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _futureData2 = fetchData(_controller.text);
                  });
                },
                child: const Text('Submit User'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.add),
        ));
        
  }
}
