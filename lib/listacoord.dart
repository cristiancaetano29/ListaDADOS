import 'package:flutter/material.dart';
import 'dataFromApi.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Insere.dart';

Future<List<dataFromApi>> fetchData() async {
  var response = await http.get(
      Uri.parse("https://www.slmm.com.br/CTC/getLista.php"),
      headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new dataFromApi.fromJson(data)).toList();
  } else {
    throw Exception('Erro inesperado....');
  }
}

class listacoord extends StatefulWidget {
  const listacoord({Key? key}) : super(key: key);

  @override
  _listacoordState createState() => _listacoordState();
}

class _listacoordState extends State<listacoord> {
  late Future<List<dataFromApi>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("listagem"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<dataFromApi>>(
            future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dataFromApi> data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                              //title: Text(data[index].id.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(data[index].nome,),
                                  Icon(Icons.bolt_rounded),
                                  IconButton(onPressed: () {},
                                  icon: Icon(Icons.favorite),
                                  )
                                ], ),
                            ));
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // by default
                return CircularProgressIndicator();
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
           onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Insere()),
            );
          },
          child: Icon(Icons.add),
        )
    );
  }
}
