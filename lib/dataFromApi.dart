class dataFromApi {
  String nome;
  String data; 

  dataFromApi(this.nome, this.data);

  Map toJson() => {'nome': nome, 'data': data};

  factory dataFromApi.fromJson(dynamic json) {
    if (json['data'] == null) json['data'] = "01/01/2022 00:00:00";
//    if (json['nome'] == null) json['nome'] = 'Sem Nome';
    
    return dataFromApi(json['nome'] as String , json['data'] as String);
  }
  
  @override
  String toString() {
    // TODO: implement toString
    return '{${this.nome} , ${this.data}}';
  }
}
